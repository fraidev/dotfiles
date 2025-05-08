return {
    -- A set of lua helpers that are used by other plugins
    "nvim-lua/plenary.nvim",
    -- Plugin to show the startuptime of neovim using :StartupTime
    "dstein64/vim-startuptime",
    "gpanders/editorconfig.nvim",
    {"JoosepAlviste/nvim-ts-context-commentstring", ft = {"typescript", "typescriptreact"}},
    -- Use devicons for filetypes
    "nvim-tree/nvim-web-devicons",
    -- Add color highlighting to hex values
    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup()
        end
    },
    -- Improve the default neovim interfaces, such as refactoring
    "stevearc/dressing.nvim",
    -- Vim-illuminate - Vim plugin for automatically highlighting
    -- other uses of the current word under the cursor
    {"RRethy/vim-illuminate"},
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = true
    },
    -- OCaml
    -- "ocaml/vim-ocaml",
    -- Rust
    {
        "mrcjkb/rustaceanvim",
        version = "^5", -- Recommended
        lazy = false, -- This plugin is already lazy
        dependencies = {
            "nvim-lua/plenary.nvim",
            "mfussenegger/nvim-dap"
        },
        config = function()
            vim.g.rustaceanvim = {
                tools = {
                    executor = "toggleterm"
                },
                server = {
                    -- default_settings = {
                    --     ["rust-analyzer"] = {
                    --         cargo = {
                    --             allFeatures = true,
                    --             loadOutDirsFromCheck = true,
                    --             runBuildScripts = true
                    --         },
                    --         procMacro = {
                    --             enable = true
                    --         },
                    --         inlayHints = {
                    --             lifetimeElisionHints = {
                    --                 enable = true,
                    --                 useParameterNames = true
                    --             }
                    --         }
                    --     }
                    -- }
                    default_settings = {
                        ["rust-analyzer"] = {
                            restartServerOnConfigChange = false,
                            showUnlinkedFileNotification = true,
                            showRequestFailedErrorNotification = true,
                            showDependenciesExplorer = true,
                            showSyntaxTree = false,
                            testExplorer = false,
                            initializeStopped = false,
                            runnables = {
                                extraEnv = nil,
                                problemMatcher = {"$rustc"},
                                askBeforeUpdateTest = true,
                                command = nil,
                                extraArgs = {},
                                extraTestBinaryArgs = {"--show-output"}
                            },
                            statusBar = {
                                clickAction = "openLogs",
                                showStatusBar = {
                                    documentSelector = {
                                        {language = "rust"},
                                        {pattern = "**/Cargo.toml"},
                                        {pattern = "**/Cargo.lock"},
                                        {scheme = "output", pattern = "extension-output-rust-lang.rust-analyzer*"}
                                    }
                                }
                            },
                            server = {
                                path = nil,
                                extraEnv = nil
                            },
                            trace = {
                                server = "off",
                                extension = false
                            },
                            debug = {
                                engine = "auto",
                                sourceFileMap = {
                                    ["/rustc/<id>"] = "${env:USERPROFILE}/.rustup/toolchains/<toolchain-id>/lib/rustlib/src/rust"
                                },
                                openDebugPane = false,
                                buildBeforeRestart = false,
                                engineSettings = {}
                            },
                            typing = {
                                continueCommentsOnNewline = true,
                                triggerChars = "=."
                            },
                            diagnostics = {
                                previewRustcOutput = false,
                                useRustcErrorCode = false,
                                disabled = {},
                                enable = true,
                                experimental = {
                                    enable = false
                                },
                                remapPrefix = {},
                                styleLints = {
                                    enable = false
                                },
                                warningsAsHint = {},
                                warningsAsInfo = {}
                            },
                            assist = {
                                emitMustUse = false,
                                expressionFillDefault = "todo",
                                termSearch = {
                                    borrowcheck = true,
                                    fuel = 1800
                                }
                            },
                            cachePriming = {
                                enable = true,
                                numThreads = "physical"
                            },
                            cargo = {
                                allTargets = true,
                                autoreload = true,
                                buildScripts = {
                                    enable = true,
                                    invocationStrategy = "per_workspace",
                                    overrideCommand = nil,
                                    rebuildOnSave = true,
                                    useRustcWrapper = true
                                },
                                cfgs = {"debug_assertions", "miri"},
                                extraArgs = {},
                                extraEnv = {},
                                features = {},
                                noDefaultFeatures = false,
                                sysroot = "discover",
                                sysrootSrc = nil,
                                target = nil,
                                targetDir = nil
                            },
                            cfg = {
                                setTest = true
                            },
                            checkOnSave = true,
                            check = {
                                allTargets = nil,
                                command = "check",
                                extraArgs = {},
                                extraEnv = {},
                                features = nil,
                                ignore = {},
                                invocationStrategy = "per_workspace",
                                noDefaultFeatures = nil,
                                overrideCommand = nil,
                                targets = nil,
                                workspace = true
                            },
                            completion = {
                                addSemicolonToUnit = true,
                                autoAwait = {
                                    enable = true
                                },
                                autoIter = {
                                    enable = true
                                },
                                autoimport = {
                                    enable = true,
                                    exclude = {
                                        {path = "core::borrow::Borrow", type = "methods"},
                                        {path = "core::borrow::BorrowMut", type = "methods"}
                                    }
                                },
                                autoself = {
                                    enable = true
                                },
                                callable = {
                                    snippets = "fill_arguments"
                                },
                                excludeTraits = {},
                                fullFunctionSignatures = {
                                    enable = false
                                },
                                hideDeprecated = false,
                                limit = nil,
                                postfix = {
                                    enable = true
                                },
                                privateEditable = {
                                    enable = false
                                },
                                snippets = {
                                    custom = {
                                        Ok = {
                                            postfix = "ok",
                                            body = "Ok(${receiver})",
                                            description = "Wrap the expression in a Result::Ok",
                                            scope = "expr"
                                        },
                                        ["Box::pin"] = {
                                            postfix = "pinbox",
                                            body = "Box::pin(${receiver})",
                                            requires = "std::boxed::Box",
                                            description = "Put the expression into a pinned Box",
                                            scope = "expr"
                                        },
                                        ["Arc::new"] = {
                                            postfix = "arc",
                                            body = "Arc::new(${receiver})",
                                            requires = "std::sync::Arc",
                                            description = "Put the expression into an Arc",
                                            scope = "expr"
                                        },
                                        Some = {
                                            postfix = "some",
                                            body = "Some(${receiver})",
                                            description = "Wrap the expression in an Option::Some",
                                            scope = "expr"
                                        },
                                        Err = {
                                            postfix = "err",
                                            body = "Err(${receiver})",
                                            description = "Wrap the expression in a Result::Err",
                                            scope = "expr"
                                        },
                                        ["Rc::new"] = {
                                            postfix = "rc",
                                            body = "Rc::new(${receiver})",
                                            requires = "std::rc::Rc",
                                            description = "Put the expression into an Rc",
                                            scope = "expr"
                                        }
                                    }
                                },
                                termSearch = {
                                    enable = false,
                                    fuel = 1000
                                }
                            },
                            files = {
                                exclude = {},
                                watcher = "client"
                            },
                            highlightRelated = {
                                breakPoints = {
                                    enable = true
                                },
                                closureCaptures = {
                                    enable = true
                                },
                                exitPoints = {
                                    enable = true
                                },
                                references = {
                                    enable = true
                                },
                                yieldPoints = {
                                    enable = true
                                }
                            },
                            hover = {
                                actions = {
                                    debug = {
                                        enable = true
                                    },
                                    enable = true,
                                    gotoTypeDef = {
                                        enable = true
                                    },
                                    implementations = {
                                        enable = true
                                    },
                                    references = {
                                        enable = false
                                    },
                                    run = {
                                        enable = true
                                    },
                                    updateTest = {
                                        enable = true
                                    }
                                },
                                documentation = {
                                    enable = true,
                                    keywords = {
                                        enable = true
                                    }
                                },
                                links = {
                                    enable = true
                                },
                                maxSubstitutionLength = 20,
                                memoryLayout = {
                                    alignment = "hexadecimal",
                                    enable = true,
                                    niches = false,
                                    offset = "hexadecimal",
                                    size = "both"
                                },
                                show = {
                                    enumVariants = 5,
                                    fields = 5,
                                    traitAssocItems = nil
                                }
                            },
                            imports = {
                                granularity = {
                                    enforce = false,
                                    group = "crate"
                                },
                                group = {
                                    enable = true
                                },
                                merge = {
                                    glob = true
                                },
                                preferNoStd = false,
                                preferPrelude = false,
                                prefix = "plain",
                                prefixExternPrelude = false
                            },
                            inlayHints = {
                                bindingModeHints = {
                                    enable = false
                                },
                                chainingHints = {
                                    enable = true
                                },
                                closingBraceHints = {
                                    enable = true,
                                    minLines = 25
                                },
                                closureCaptureHints = {
                                    enable = false
                                },
                                closureReturnTypeHints = {
                                    enable = "never"
                                },
                                closureStyle = "impl_fn",
                                discriminantHints = {
                                    enable = "never"
                                },
                                expressionAdjustmentHints = {
                                    enable = "never",
                                    hideOutsideUnsafe = false,
                                    mode = "prefix"
                                },
                                genericParameterHints = {
                                    const = {
                                        enable = true
                                    },
                                    lifetime = {
                                        enable = false
                                    },
                                    type = {
                                        enable = false
                                    }
                                },
                                implicitDrops = {
                                    enable = false
                                },
                                implicitSizedBoundHints = {
                                    enable = false
                                },
                                lifetimeElisionHints = {
                                    enable = "never",
                                    useParameterNames = false
                                },
                                maxLength = 25,
                                parameterHints = {
                                    enable = true
                                },
                                rangeExclusiveHints = {
                                    enable = false
                                },
                                reborrowHints = {
                                    enable = "never"
                                },
                                renderColons = true,
                                typeHints = {
                                    enable = true,
                                    hideClosureInitialization = false,
                                    hideClosureParameter = false,
                                    hideNamedConstructor = false
                                }
                            },
                            interpret = {
                                tests = false
                            },
                            joinLines = {
                                joinAssignments = true,
                                joinElseIf = true,
                                removeTrailingComma = true,
                                unwrapTrivialBlock = true
                            },
                            lens = {
                                debug = {
                                    enable = true
                                },
                                enable = true,
                                implementations = {
                                    enable = true
                                },
                                location = "above_name",
                                references = {
                                    adt = {
                                        enable = false
                                    },
                                    enumVariant = {
                                        enable = false
                                    },
                                    method = {
                                        enable = false
                                    },
                                    trait = {
                                        enable = false
                                    }
                                },
                                run = {
                                    enable = true
                                },
                                updateTest = {
                                    enable = true
                                }
                            },
                            linkedProjects = {},
                            lru = {
                                capacity = nil,
                                query = {
                                    capacities = {}
                                }
                            },
                            notifications = {
                                cargoTomlNotFound = true
                            },
                            numThreads = nil,
                            procMacro = {
                                attributes = {
                                    enable = true
                                },
                                enable = true,
                                ignored = {},
                                server = nil
                            },
                            references = {
                                excludeImports = false,
                                excludeTests = false
                            },
                            rustc = {
                                source = nil
                            },
                            rustfmt = {
                                extraArgs = {},
                                overrideCommand = nil,
                                rangeFormatting = {
                                    enable = false
                                }
                            },
                            semanticHighlighting = {
                                doc = {
                                    comment = {
                                        inject = {
                                            enable = true
                                        }
                                    }
                                },
                                nonStandardTokens = true,
                                operator = {
                                    enable = true,
                                    specialization = {
                                        enable = false
                                    }
                                },
                                punctuation = {
                                    enable = false,
                                    separate = {
                                        macro = {
                                            bang = false
                                        }
                                    },
                                    specialization = {
                                        enable = false
                                    }
                                },
                                strings = {
                                    enable = true
                                }
                            },
                            signatureInfo = {
                                detail = "full",
                                documentation = {
                                    enable = true
                                }
                            },
                            vfs = {
                                extraIncludes = {}
                            },
                            workspace = {
                                discoverConfig = nil,
                                symbol = {
                                    search = {
                                        kind = "only_types",
                                        limit = 128,
                                        scope = "workspace"
                                    }
                                }
                            }
                        }
                    }
                }
            }
            -- inlay_hints = {
            --     highlight = "NonText"
            -- },
            -- tools = {
            --     float_win_config = {
            --         border = "rounded"
            --     },
            --     hover_actions = {
            --         auto_focus = true
            --     }
            -- },
            -- server = {
            --     default_settings = {
            --         -- rust-analyzer language server configuration
            --         ["rust-analyzer"] = {
            --             imports = {
            --                 granularity = {
            --                     group = "module"
            --                 },
            --                 prefix = "self"
            --             },
            --             cargo = {
            --                 allFeatures = true,
            --                 loadOutDirsFromCheck = true,
            --                 buildScripts = {
            --                     enable = true
            --                 }
            --             },
            --             assist = {
            --                 importMergeBehavior = "last",
            --                 importPrefix = "by_self"
            --             },
            --             procMacro = {
            --                 enable = true
            --             }
            --         }
            --     }
            -- }
            -- }
        end
    },
    -- Go
    {"fatih/vim-go", build = ":GoUpdateBinaries"},
    {
        "folke/todo-comments.nvim",
        dependencies = {"nvim-lua/plenary.nvim"},
        opts = {}
    },
    {
        "m00qek/baleia.nvim",
        version = "*",
        config = function()
            vim.g.baleia = require("baleia").setup({})

            -- Command to colorize the current buffer
            vim.api.nvim_create_user_command(
                "BaleiaColorize",
                function()
                    vim.g.baleia.once(vim.api.nvim_get_current_buf())
                end,
                {bang = true}
            )

            -- Command to show logs
            vim.api.nvim_create_user_command("BaleiaLogs", vim.g.baleia.logger.show, {bang = true})
        end
    }
    -- {
    --     "cordx56/rustowl",
    --     dependencies = {"neovim/nvim-lspconfig"},
    --     config = function()
    --         local lspconfig = require("lspconfig")
    --         lspconfig.rustowlsp.setup({})
    --     end
    -- }
}
