{ pkgs, ... }: {
  home.packages = [ pkgs.llvmPackages.lit ];
}
