inputs: let
  username = "mozsoy";

  darwinModules = import ../../modules/darwin inputs;
  homeManagerModules = import ../../modules/home_manager inputs;
  aliasScript = import ./scripts/alias_script.nix username;

  mkDarwinConfig = username: appsModule:
    inputs.nix-darwin.lib.darwinSystem {
      modules = [
        (darwinModules.mkDarwin username)
        aliasScript
        homeManagerModules.homeManager
        appsModule
      ];
    };

  in {
    MacbookProFull = mkDarwinConfig username { 
      custom.apps = [ "android" "vscode" "spotify" "htop" "uv" "cursor" "tex-live" "docker" "colima" "zsh" "openclaw" "openssl" "boost" "clang_tools" "llvm" "mlir" "chrome" "openmp" "discord" "ninja" "xcode" "neovim" "opencode" "pi" "cursor_agent" "glow" "life-tracker" "ffmpeg"];
    };
    MacbookProStandard = mkDarwinConfig username { 
      custom.apps = [ "android" "spotify" "vscode" "uv" "tex-live" "cmake"  "clang_tools" "llvm" "mlir" "chrome" "wezterm" "zsh" "herdr" "codex" "neovim" "opencode" "pi" "cursor_agent" "glow" "rustup" "life-tracker" "ffmpeg"];
    };
    MacbookProMinimal = mkDarwinConfig username { 
      custom.apps = []; 
    };
  }
