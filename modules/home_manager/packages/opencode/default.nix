{ pkgs, ... }:
let
  cursorPlugin = import ./cursor_plugin.nix;
in
{
  home.packages = [ pkgs.opencode ];

  xdg.configFile."opencode/opencode.json".text = builtins.toJSON cursorPlugin;
}
