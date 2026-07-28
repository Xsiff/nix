{ pkgs, ... }:
 {
  home.packages = [ 
    pkgs.wezterm 
    pkgs.nerd-fonts.hack
  ];
  home.file = {
    ".wezterm.lua".source = ./wezterm.lua;
  };
}
