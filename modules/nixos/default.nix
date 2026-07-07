inputs: {
  mkNixOS = username: {
    imports = [
      ./app_options.nix
      ./system_settings.nix
    ];
    
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    system.stateVersion = "24.05"; # Set to your NixOS version
    nixpkgs.hostPlatform = "x86_64-linux"; # Change to "aarch64-linux" for ARM
    
    # User configuration
    users.users.${username} = {
      isNormalUser = true;
      home = "/home/${username}";
      description = username;
      extraGroups = [ "wheel" "networkmanager" "video" "audio" "docker" ];
    };
    
    # Enable sudo for wheel group
    security.sudo.wheelNeedsPassword = true;
  };
}
