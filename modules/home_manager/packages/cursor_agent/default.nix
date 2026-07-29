{ pkgs, ... }:
{
  home.packages = [ pkgs.llm-agents."cursor-agent" ];
}
