---
name: add
description: Add a requested program to this repository's Nix flake by following its package-module architecture. Use when invoked like `$add tmux`, `$add ripgrep to MacbookProStandard`, or when the user asks to add a package/tool/program/app to this repo's Home Manager profiles.
---

# Add A Program To This Repo

Add the requested program by respecting this repository's architecture:

```text
configurations/*/default.nix custom.apps
  -> modules/home_manager/packages/default.nix registry
  -> modules/home_manager/packages/<name>/default.nix module
```

## Inputs

- The argument after `$add` is the program/package name, for example `tmux`.
- If the user names profiles, change only those profiles.
- If no profile is named, default to `MacbookProStandard` and `DesktopStandard`.
- If the user says Darwin/macOS only, target Darwin profiles only. If they say NixOS/Linux only, target NixOS profiles only.

## Workflow

1. Read `AGENTS.md`, `git status --short`, `flake.nix`, `configurations/darwin/default.nix`, `configurations/nixos/default.nix`, `modules/home_manager/default.nix`, and `modules/home_manager/packages/default.nix`.
2. Check whether `modules/home_manager/packages/<name>/default.nix` already exists and whether `<name>` is already in the package registry or target `custom.apps` lists.
3. If the package module is missing, create it as:

   ```nix
   { pkgs, ... }: {
     home.packages = [ pkgs.<name> ];
   }
   ```

   Use the requested name as the default `pkgs` attribute. If nearby modules or Nixpkgs conventions clearly show a different attribute name is required, use that instead and explain it.

4. If the registry entry is missing, add `<name> = [ ./<name> ];` to `modules/home_manager/packages/default.nix`, keeping the local formatting style.
5. Add `"<name>"` to each intended profile's `custom.apps` list in `configurations/darwin/default.nix` and/or `configurations/nixos/default.nix`. Do not add duplicates.
6. For a newly created module, run `git add modules/home_manager/packages/<name>/default.nix` before validation because flakes only see tracked files.
7. Validate with the lightest relevant command:
   - Darwin profile changed: `nix eval .#darwinConfigurations.MacbookProStandard.config.system.build.toplevel.drvPath`
   - NixOS profile changed: `nix eval .#nixosConfigurations.DesktopStandard.config.system.build.toplevel.drvPath`
   - If named profiles differ, substitute the named profile.
   - If evaluation needs network or sandbox escalation, request approval and rerun.

## Editing Rules

- Use `apply_patch` for manual edits.
- Do not revert unrelated user changes.
- Preserve existing package/module style, including two-space Nix indentation.
- Keep profile changes explicit in `custom.apps`.
- If the package name is ambiguous or not a valid Nixpkgs attribute, inspect local examples first; ask only if there is no safe interpretation.

## Final Response

Report:

- The package module path created or reused.
- The registry entry added or reused.
- The profiles updated.
- The validation command and result, or why validation could not run.
