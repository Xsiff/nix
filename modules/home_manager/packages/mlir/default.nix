{ pkgs, ... }: {
  home.packages = [ pkgs.llvmPackages.mlir ];
}
