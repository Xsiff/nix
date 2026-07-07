pkgs:
let
  # ms-vscode.cpptools is blocked by nix-vscode-extensions on all platforms
  # because it ships per-platform VSIXes with bundled native binaries.
  # We bypass the guard by fetching directly from GitHub Releases, which always
  # serves a proper ZIP (the marketplace endpoint returns gzip-compressed data
  # that unzip cannot handle).

  # Maps Nix system → GitHub release asset name suffix.
  platformMap = {
    "aarch64-darwin" = "macOS-arm64";
    "x86_64-darwin"  = "macOS-x64";
    "x86_64-linux"   = "linux-x64";
    "aarch64-linux"  = "linux-arm64";
  };

  # To add a hash for another platform:
  #   nix-prefetch-url "https://github.com/microsoft/vscode-cpptools/releases/download/v<version>/cpptools-<platform>.vsix"
  # then: nix hash convert --hash-algo sha256 --to sri <base32>
  platformHashes = {
    "macOS-arm64" = "sha256-W4UQaVz/co9QpX/Tz2BzjTLnQoblF8ebqBEPH25f7Lg=";
  };

  version        = "1.32.1";
  githubPlatform = platformMap.${pkgs.stdenv.hostPlatform.system};

  cpptools = (pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      name      = "cpptools";
      publisher = "ms-vscode";
      inherit version;
      sha256    = platformHashes.${githubPlatform};
    };
  }).overrideAttrs (_: {
    src = pkgs.fetchurl {
      name   = "ms-vscode.cpptools-${version}-${githubPlatform}.vsix";
      url    = "https://github.com/microsoft/vscode-cpptools/releases/download/v${version}/cpptools-${githubPlatform}.vsix";
      sha256 = platformHashes.${githubPlatform};
    };
  });
in
with pkgs.vscode-marketplace; [
  cpptools
  franneck94.c-cpp-runner
  ms-vscode.cmake-tools
  ms-vscode.cpptools-themes
]