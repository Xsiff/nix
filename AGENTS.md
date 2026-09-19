# Repository Guidelines

## Project Structure & Module Organization

This repository is a Nix flake for macOS `nix-darwin`, NixOS, and Home Manager configuration. The main entry point is `flake.nix`, with locked inputs in `flake.lock`.

- `configurations/darwin/default.nix`: macOS profiles such as `MacbookProStandard`.
- `configurations/nixos/default.nix`: NixOS profiles such as `DesktopStandard`.
- `modules/darwin/`: system-level macOS settings and options.
- `modules/nixos/`: system-level NixOS settings and options.
- `modules/home_manager/`: user-level Home Manager setup.
- `modules/home_manager/packages/<name>/default.nix`: one module per app or tool.

There is no conventional application source tree or test asset directory; most changes are Nix module edits.

## Build, Test, and Development Commands

- `darwin-rebuild switch --flake .#MacbookProStandard`: apply the standard macOS profile.
- `darwin-rebuild build --flake .#MacbookProStandard`: build the macOS profile without switching.
- `nix eval .#darwinConfigurations.MacbookProStandard.config.system.build.toplevel.drvPath`: evaluate the Darwin configuration quickly.
- `nix flake check --no-build`: evaluate flake outputs without building derivations.
- `nix flake update`: update locked flake inputs.

When adding a new package module, remember that flakes only see files tracked by Git. Run `git add modules/home_manager/packages/<name>/default.nix` before evaluation.

## Coding Style & Naming Conventions

Use two-space indentation for Nix expressions and keep modules small. Package modules should normally follow this pattern:

```nix
{ pkgs, ... }: {
  home.packages = [ pkgs.packageName ];
}
```

Use lowercase, hyphenated directory names where they match package names, and existing underscore names only when preserving local convention, such as `clang_tools` or `cursor_agent`.

## Testing Guidelines

There is no dedicated test suite. Validate changes by evaluating or building the affected profile. For package additions, prefer a targeted `nix eval` first, then run the relevant `darwin-rebuild build` or NixOS build command before switching.

## Commit & Pull Request Guidelines

Recent commits use short, direct summaries, for example `mlir is added` and `ffmpeg is added`. Keep commits focused on one tool, profile, or configuration area.

Pull requests should include a brief description, the affected profiles, and the validation command used. Mention any known evaluation limitations or unrelated existing failures.

## Agent-Specific Instructions

Before editing, check whether the target file already has user changes. Do not revert unrelated work. Keep profile changes explicit by adding package names to the intended `custom.apps` lists in `configurations/`.
