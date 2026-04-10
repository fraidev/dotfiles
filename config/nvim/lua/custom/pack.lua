local M = {}

local plugin_dir = vim.fn.stdpath("config") .. "/lua/custom/plugins"
local pack_changed_group = vim.api.nvim_create_augroup("CustomPackHooks", { clear = true })

local build_hooks = {}
local added = {}
local loaded = {}

local function github_url(repo)
    if repo:find("://", 1, true) or repo:match("^%a[%w+.-]*:") then
        return repo
    end

    return "https://github.com/" .. repo
end

local function repo_name_from_src(src)
    local tail = src:gsub("/+$", ""):match("([^/]+)$") or src
    return tail:gsub("%.git$", "")
end

local function plugin_name(spec)
    return spec.name or repo_name_from_src(spec.src)
end

local function infer_setup_module(name)
    if name:match("^mini%.") then
        return name
    end

    return name:gsub("%.nvim$", ""):gsub("%.lua$", ""):gsub("^nvim%-", ""):gsub("^vim%-", "")
end

local function build_version(spec)
    if type(spec.version) == "string" then
        if spec.version == "*" then
            return nil
        end

        if spec.version:find("*", 1, true) or spec.version:find("^", 1, true) or spec.version:find("~", 1, true) or
            spec.version:find(">", 1, true) or spec.version:find("<", 1, true) then
            return vim.version.range(spec.version:gsub("^v", ""))
        end

        return spec.version
    end

    if spec.version == false then
        return nil
    end

    return spec.branch or spec.tag or spec.commit or spec.version
end

local function normalize_spec(spec)
    if type(spec) == "string" then
        return {
            src = github_url(spec),
            name = repo_name_from_src(github_url(spec)),
        }
    end

    local normalized = vim.deepcopy(spec)
    local src = normalized.src or normalized[1]

    if not src then
        error("Invalid plugin spec without source")
    end

    normalized.src = github_url(src)
    normalized.name = normalized.name or repo_name_from_src(normalized.src)
    normalized.version = build_version(normalized)

    local positional_dependencies = {}
    for i = 2, #normalized do
        positional_dependencies[#positional_dependencies + 1] = normalized[i]
    end

    if not vim.tbl_isempty(positional_dependencies) then
        normalized.dependencies = normalized.dependencies or {}
        vim.list_extend(normalized.dependencies, positional_dependencies)
    end

    normalized[1] = nil
    for i = 2, #normalized do
        normalized[i] = nil
    end
    normalized.branch = nil
    normalized.tag = nil
    normalized.commit = nil

    return normalized
end

local function is_single_spec(tbl)
    if type(tbl) ~= "table" then
        return false
    end

    if tbl.src ~= nil or tbl.name ~= nil or tbl.dependencies ~= nil or tbl.config ~= nil or tbl.opts ~= nil or
        tbl.event ~= nil or tbl.ft ~= nil or tbl.lazy ~= nil or tbl.build ~= nil or tbl.keys ~= nil or
        tbl.version ~= nil or tbl.branch ~= nil or tbl.tag ~= nil or tbl.commit ~= nil then
        return true
    end

    return type(tbl[1]) == "string" and tbl[2] == nil
end

local function module_specs(mod)
    if is_single_spec(mod) then
        return { mod }
    end

    return mod
end

local function command_args(cmd)
    return vim.split(cmd, "%s+", { trimempty = true })
end

local function run_build(name, build, ev)
    if type(build) ~= "string" or build == "" then
        return
    end

    if build:sub(1, 1) == ":" then
        if not ev.data.active then
            vim.cmd.packadd(name)
        end
        vim.cmd(build:sub(2))
        return
    end

    local result = vim.system(command_args(build), { cwd = ev.data.path }):wait()
    if result.code ~= 0 then
        vim.schedule(
            function()
                vim.notify(
                    string.format("Build failed for %s: %s", name, result.stderr or result.stdout or ""),
                    vim.log.levels.ERROR
                )
            end
        )
    end
end

local function register_build_hook(spec)
    if spec.build == nil then
        return
    end

    build_hooks[plugin_name(spec)] = spec.build
end

local function register_keys(spec)
    local keys = spec.keys
    if type(keys) == "function" then
        keys = keys()
    end

    if type(keys) ~= "table" then
        return
    end

    for _, map in ipairs(keys) do
        local lhs = map[1]
        local rhs = map[2]
        local mode = map.mode or "n"
        local opts = {
            desc = map.desc,
            expr = map.expr,
            nowait = map.nowait,
            remap = map.remap,
            silent = map.silent,
            buffer = map.buffer,
        }

        vim.keymap.set(mode, lhs, rhs, opts)
    end
end

local function run_setup(spec)
    if loaded[spec.name] then
        return
    end

    loaded[spec.name] = true

    if type(spec.config) == "function" then
        spec.config()
    elseif spec.config == true or spec.opts ~= nil then
        local ok, plugin = pcall(require, infer_setup_module(spec.name))
        if ok and type(plugin.setup) == "function" then
            plugin.setup(spec.opts or {})
        end
    end

    register_keys(spec)
end

local add_spec

local function load_plugin(spec)
    if spec.dependencies then
        for _, dep in ipairs(spec.dependencies) do
            add_spec(dep, true)
        end
    end

    if not added[spec.name] then
        vim.pack.add({
            {
                src = spec.src,
                name = spec.name,
                version = spec.version,
            },
        }, { load = true, confirm = true })
        added[spec.name] = true
    end

    run_setup(spec)
end

local function create_lazy_loader(spec)
    local events = spec.event
    local patterns = nil

    if spec.ft then
        events = { "FileType" }
        patterns = spec.ft
    elseif type(events) == "string" then
        events = { events }
    end

    if type(events) ~= "table" or vim.tbl_isempty(events) then
        load_plugin(spec)
        return
    end

    for _, event_spec in ipairs(events) do
        local event = event_spec
        local pattern = patterns

        if spec.ft == nil then
            local parts = vim.split(event_spec, " ", { trimempty = true, plain = true })
            event = parts[1]
            if #parts > 1 then
                pattern = table.concat(parts, " ", 2)
            end
        end

        vim.api.nvim_create_autocmd(event, {
            group = pack_changed_group,
            once = true,
            pattern = pattern,
            callback = function()
                load_plugin(spec)
            end,
        })
    end
end

add_spec = function(raw_spec, force_load)
    local spec = normalize_spec(raw_spec)
    register_build_hook(spec)

    if force_load or (spec.lazy ~= true and spec.event == nil and spec.ft == nil) then
        load_plugin(spec)
        return
    end

    create_lazy_loader(spec)
end

local function plugin_modules()
    local files = vim.fn.readdir(plugin_dir, [[v:val =~ '\.lua$']])
    table.sort(files)
    return files
end

local function load_modules()
    for _, file in ipairs(plugin_modules()) do
        local module_name = "custom.plugins." .. file:gsub("%.lua$", "")
        local ok, specs = pcall(require, module_name)
        if not ok then
            error(specs)
        end

        for _, spec in ipairs(module_specs(specs)) do
            add_spec(spec, false)
        end
    end
end

function M.setup()
    vim.api.nvim_create_autocmd("PackChanged", {
        group = pack_changed_group,
        callback = function(ev)
            local name = ev.data.spec.name
            local kind = ev.data.kind
            local build = build_hooks[name]

            if build ~= nil and (kind == "install" or kind == "update") then
                run_build(name, build, ev)
            end
        end,
    })

    load_modules()
end

return M
