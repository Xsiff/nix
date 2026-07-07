# TOOLS.md — Available Tools

## Enabled Plugins

### summarize
Summarize web pages, PDFs, and YouTube videos.
- Usage: ask to summarize a URL
- Example: "summarize https://example.com/article"

### peekaboo
Take screenshots of the current screen.
- Usage: ask to take a screenshot or describe what's on screen
- Example: "what's on my screen right now?"

## Adding More Plugins

To add more plugins, edit `modules/home_manager/openclaw/default.nix` in your
nix config and add entries to `instances.default.plugins`.

Available bundled plugins (set `bundledPlugins.<name>.enable = true`):
- `poltergeist` — control macOS UI (click, type)
- `sag` — text-to-speech
- `camsnap` — camera snapshots
- `gogcli` — Google Calendar
- `goplaces` — Google Places API
- `sonoscli` — Sonos speaker control
- `imsg` — iMessage

See: https://github.com/openclaw/nix-openclaw#plugins
