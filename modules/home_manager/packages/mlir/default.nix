{ pkgs, ... }: {
  home.packages = [
    pkgs.llvmPackages.mlir
    pkgs.llvmPackages.mlir.dev
  ];
}
