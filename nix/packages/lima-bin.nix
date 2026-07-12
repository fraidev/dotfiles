# Prebuilt lima from GitHub releases.
# nixpkgs' lima fails to link on macOS 26 (cctools ld Trace/BPT trap when
# linking Virtualization.framework), and aarch64-darwin builds are not on
# cache.nixos.org — so we ship the official binary instead.
{
  lib,
  stdenv,
  fetchurl,
}:

stdenv.mkDerivation rec {
  pname = "lima";
  version = "2.1.4";

  src =
    let
      system = stdenv.hostPlatform.system;
      # release asset names use Darwin/Linux + arm64/x86_64/aarch64
      assets = {
        "aarch64-darwin" = {
          name = "lima-${version}-Darwin-arm64.tar.gz";
          hash = "sha256-FMWyg/HF60B45aMAuNJB9pGXo+QTJt/GhaaclFWRes8=";
        };
      };
      asset = assets.${system} or (throw "lima-bin: unsupported system ${system} (add hash in lima-bin.nix)");
    in
    fetchurl {
      url = "https://github.com/lima-vm/lima/releases/download/v${version}/${asset.name}";
      inherit (asset) hash;
    };

  # Official tarball has bin/ libexec/ share/ at the root (no single top-level dir).
  sourceRoot = ".";
  setSourceRoot = "sourceRoot=`pwd`";

  # strip removes codesign entitlements needed for Virtualization.framework (vz).
  dontStrip = stdenv.hostPlatform.isDarwin;

  installPhase = ''
    runHook preInstall
    mkdir -p $out
    cp -a bin libexec share $out/
    runHook postInstall
  '';

  meta = {
    description = "Linux virtual machines with automatic file sharing and port forwarding (prebuilt binary)";
    homepage = "https://github.com/lima-vm/lima";
    changelog = "https://github.com/lima-vm/lima/releases/tag/v${version}";
    license = lib.licenses.asl20;
    platforms = [ "aarch64-darwin" ];
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    mainProgram = "limactl";
  };
}
