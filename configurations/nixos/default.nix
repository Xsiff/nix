inputs: let
  username = "mozsoy";

  nixosModules = import ../../modules/nixos inputs;
  homeManagerModules = import ../../modules/home_manager inputs;

  mkNixOSConfig = username: appsModule:
    inputs.nixpkgs.lib.nixosSystem {
      modules = [
        (nixosModules.mkNixOS username)
        homeManagerModules.homeManager
        appsModule
        
        # You'll need to add your hardware configuration here
        # Usually located at /etc/nixos/hardware-configuration.nix
        # ./hardware-configuration.nix
      ];
    };

  in {
    DesktopFull = mkNixOSConfig username { 
      custom.apps = [ "vscode" "spotify" "htop" "uv" "cursor" "tex-live" "docker" "zsh" ]; 
    };
    DesktopStandard = mkNixOSConfig username { 
      custom.apps = [ "cursor" "spotify" "vscode" "uv" "rustup" "chrome" "dotnet" ]; 
    };
    DesktopMinimal = mkNixOSConfig username { 
      custom.apps = []; 
    };
  }
