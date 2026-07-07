inputs: {
  mkDarwin = username: {
    imports = [
      ./app_options.nix
      ./dock_settings.nix
    ];
    
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    system.stateVersion = 5;
    nixpkgs.hostPlatform = "aarch64-darwin";
    system.primaryUser = username;
    # environment.systemPackages = [ inputs.nix-darwin.pkgs.darwin.xcode ];
    users.users.${username} = {
      home = "/Users/${username}";
      name = username;
    };
  };
}
