{ pkgs, ... }:
{
  programs.pi.coding-agent = {
    enable = true;
    package = pkgs.pi-coding-agent;
  };

  home.file.".pi/agent/models.json".source = ./models.json;
}
