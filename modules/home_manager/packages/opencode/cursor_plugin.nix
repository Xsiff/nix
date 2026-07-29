{
  plugin = [ "@rama_nigg/open-cursor@latest" ];
  provider = {
    cursor-acp = {
      name = "Cursor ACP";
      npm = "@ai-sdk/openai-compatible";
      options = {
        baseURL = "http://127.0.0.1:32124/v1";
      };
      models = {
        "cursor-acp/auto" = { name = "Auto"; };
        "cursor-acp/gpt-5.3-codex-low" = { name = "Codex 5.3 Low"; };
        "cursor-acp/gpt-5.3-codex" = { name = "Codex 5.3"; };
        "cursor-acp/gpt-5.3-codex-high" = { name = "Codex 5.3 High"; };
        "cursor-acp/gpt-5.2" = { name = "GPT-5.2"; };
        "cursor-acp/gpt-5-mini" = { name = "GPT-5 Mini"; };
        "cursor-acp/composer-2.5" = { name = "Composer 2.5"; };
        "cursor-acp/composer-2.5-fast" = { name = "Composer 2.5 Fast"; };
        "cursor-acp/claude-opus-5-low" = { name = "Opus 5 1M Low"; };
        "cursor-acp/claude-opus-5-medium" = { name = "Opus 5 1M Medium"; };
        "cursor-acp/claude-opus-5-high" = { name = "Opus 5 1M"; };
        "cursor-acp/claude-opus-5-thinking-high" = { name = "Opus 5 1M Thinking"; };
        "cursor-acp/claude-opus-4-8-low" = { name = "Opus 4.8 1M Low"; };
        "cursor-acp/claude-opus-4-8-medium" = { name = "Opus 4.8 1M Medium"; };
        "cursor-acp/claude-opus-4-8-high" = { name = "Opus 4.8 1M"; };
        "cursor-acp/claude-opus-4-8-thinking-high" = { name = "Opus 4.8 1M Thinking"; };
        "cursor-acp/claude-sonnet-5-medium" = { name = "Sonnet 5 1M Medium"; };
        "cursor-acp/claude-sonnet-5-high" = { name = "Sonnet 5 1M"; };
        "cursor-acp/claude-sonnet-5-thinking-high" = { name = "Sonnet 5 1M Thinking"; };
        "cursor-acp/claude-4.5-sonnet" = { name = "Sonnet 4.5"; };
        "cursor-acp/claude-4.5-sonnet-thinking" = { name = "Sonnet 4.5 Thinking"; };
        "cursor-acp/gemini-3.1-pro" = { name = "Gemini 3.1 Pro"; };
        "cursor-acp/gemini-3-flash" = { name = "Gemini 3 Flash (current)"; };
        "cursor-acp/kimi-k3-max" = { name = "Kimi K3"; };
        "cursor-acp/grok-4.5-high" = { name = "Cursor Grok 4.5 High"; };
        "cursor-acp/grok-4.5-medium" = { name = "Cursor Grok 4.5 Medium"; };
        "cursor-acp/grok-4.5-low" = { name = "Cursor Grok 4.5 Low"; };
      };
    };
  };
}
