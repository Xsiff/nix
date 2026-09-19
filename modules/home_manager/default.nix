inputs: let
  username = "mozsoy";
  packages = import ./packages;
  
  # Converts list of package names to list of imports
  mkModules = names: builtins.concatLists (map (name: packages.${name}) names);

  mkHomeConfig = username: programs: {
    imports = programs ++ [
      inputs.nix-openclaw.homeManagerModules.openclaw
      inputs.pi.homeModules.default
    ];
    home = {
      username = username;
      homeDirectory = "/Users/${username}";
      stateVersion = "24.05";
    };
  };

  mkModule = username: { config, ... }: {
    imports = [ inputs.home-manager.darwinModules.home-manager ];
    nixpkgs.config = {
      allowUnfree = true;
      android_sdk.accept_license = true;
    };
    home-manager.useGlobalPkgs = true;
    nixpkgs.overlays = [
      inputs.vscode-extensions.overlays.default
      inputs.nix-openclaw.overlays.default
      inputs.llm-agents.overlays.shared-nixpkgs
      inputs.pi.overlays.default
      (final: _: let
        system = final.stdenv.hostPlatform.system;
      in {
        life-tracker = inputs.life-tracker.packages.${system}.default;
        herdr = inputs.herdr.packages.${system}.herdr;
      })
    ];
    home-manager.users.${username} = mkHomeConfig username (mkModules config.custom.apps);
  };

in
{
  homeManager = mkModule username;
}
