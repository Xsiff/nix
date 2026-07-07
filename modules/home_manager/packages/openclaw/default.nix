{ ... }:
{
  programs.openclaw = {
    enable = true;

    # Documents directory for AGENTS.md, SOUL.md, TOOLS.md etc.
    documents = ./documents;

    config = {
      gateway = {
        mode = "local";
        auth.token = "local-gateway-token";
      };
    };

    instances.default = {
      enable = true;
      plugins = [];
    };
  };
}
