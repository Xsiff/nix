{ config, lib, ... }:
let
  apps = config.custom.apps;
  
  # Base apps that are always in the dock
  baseApps = [
    { app = "/Applications/Safari.app"; }
    { app = "/System/Applications/Utilities/Terminal.app"; }
  ];

  # Conditional apps based on enabled apps (Nix apps are in /Applications/Nix Apps/)
  optionalApps = lib.optionals (builtins.elem "spotify" apps) [
    { app = "/Applications/Nix Apps/Spotify.app"; }
  ];
in
{
  config.system.defaults.dock.persistent-apps = baseApps ++ optionalApps;
}
