{ lib, ... }:
{
  options.custom.apps = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [];
    description = "List of apps to install";
  };
}
