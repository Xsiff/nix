{ pkgs }:
let
  llvmTblgen = pkgs.llvmPackages."llvm-tblgen";
in
pkgs.runCommandNoCC "mlir-tblgen-${llvmTblgen.version}" {} ''
  mkdir -p "$out/bin"
  ln -s "${llvmTblgen}/bin/mlir-tblgen" "$out/bin/mlir-tblgen"
''
