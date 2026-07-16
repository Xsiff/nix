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
      custom.apps = [ "vscode" "spotify" "htop" "uv" "cursor" "tex-live" "docker" "colima" "zsh" "openclaw" "openssl" "boost" "clang_tools" "chrome" "openmp" "discord" "ninja" "xcode"]; 
    };
    MacbookProStandard = mkDarwinConfig username { 
      custom.apps = [ "spotify" "vscode" "rustup" "uv" "cursor" "tex-live" "cmake"  "clang_tools" "chrome" "openmp" "dotnet"]; 
    };
    MacbookProMinimal = mkDarwinConfig username { 
      custom.apps = []; 
    };
  }
