inputs: let
  username = "mozsoy";
  packages = import ./packages;
  
  # Converts list of package names to list of imports
  mkModules = names: builtins.concatLists (map (name: packages.${name}) names);

  mkHomeConfig = username: programs: {
    imports = programs ++ [ inputs.nix-openclaw.homeManagerModules.openclaw ];
    home = {
      username = username;
      homeDirectory = "/Users/${username}";
      stateVersion = "24.05";
    };
  };

  mkModule = username: { config, ... }: {
    imports = [ inputs.home-manager.darwinModules.home-manager ];
    nixpkgs.config.allowUnfree = true;
    home-manager.useGlobalPkgs = true;
    nixpkgs.overlays = [
      inputs.vscode-extensions.overlays.default
      inputs.nix-openclaw.overlays.default
    ];
    home-manager.users.${username} = mkHomeConfig username (mkModules config.custom.apps);
  };

in
{
  homeManager = mkModule username;
}
