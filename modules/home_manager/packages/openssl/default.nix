{ pkgs, ... }: {
  home.packages = [ pkgs.openssl pkgs.openssl.dev pkgs.openssl.out];
}
