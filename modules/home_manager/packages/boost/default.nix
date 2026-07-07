{ pkgs, ... }: {
  home.packages = [ pkgs.boost pkgs.boost.dev ]; # includes headers
}
