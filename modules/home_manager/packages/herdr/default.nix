{ pkgs, ... }: {
  home.packages = [ pkgs.herdr ];

  xdg.configFile."herdr/config.toml".text = ''
    [experimental]
    allow_nested = true
  '';
}
