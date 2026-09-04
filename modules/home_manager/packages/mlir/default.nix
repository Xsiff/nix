{ pkgs, ... }:
let
  mlirTblgen = import ./tblgen.nix { inherit pkgs; };
in
{
  home.packages = [
    pkgs.llvmPackages.mlir
    # Provides MLIR headers and CMake files.
    pkgs.llvmPackages.mlir.dev
    mlirTblgen
  ];
}
