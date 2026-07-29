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
        "cursor-acp/claude-opus-4-7" = { name = "Claude 4.7 Opus"; };
        "cursor-acp/claude-4.6-opus" = { name = "Claude 4.6 Opus"; };
        "cursor-acp/claude-4.6-sonnet" = { name = "Claude 4.6 Sonnet"; };
        "cursor-acp/gpt-5-mini" = { name = "GPT-5 Mini"; };
        "cursor-acp/gemini-3.1-pro" = { name = "Gemini 3.1 Pro"; };
        "cursor-acp/gemini-3-pro" = { name = "Gemini 3 Pro"; };
        "cursor-acp/gemini-3-flash" = { name = "Gemini 3 Flash"; };
        "cursor-acp/composer-2" = { name = "Composer 2"; };
        "cursor-acp/composer-2-fast" = { name = "Composer 2 Fast"; };
        "cursor-acp/composer-1.5" = { name = "Composer 1.5"; };
        "cursor-acp/grok-4-20" = { name = "Grok 4.20"; };
        "cursor-acp/kimi-k2.5" = { name = "Kimi K2.5"; };
      };
    };
  };
}
