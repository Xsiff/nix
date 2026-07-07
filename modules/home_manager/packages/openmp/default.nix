{ pkgs, ... }: {
  home.packages = [ pkgs.llvmPackages.openmp ];

  home.sessionVariables = {
    DYLD_LIBRARY_PATH = "${pkgs.llvmPackages.openmp}/lib";
  };
}
