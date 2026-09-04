{ pkgs, ... }: {
  home.packages = [
    pkgs.llvm
    pkgs.llvm.dev
  ];
}
