---
name: delete
description: Remove a requested program from this repository's Nix flake by following its package-module architecture. Use when invoked like `$delete tmux`, `$delete ripgrep from MacbookProStandard`, or when the user asks to remove/delete/uninstall a package/tool/program/app from this repo's Home Manager profiles.
---

# Delete A Program From This Repo

Remove the requested program by respecting this repository's architecture:

```text
configurations/*/default.nix custom.apps
  -> modules/home_manager/packages/default.nix registry
  -> modules/home_manager/packages/<name>/default.nix module
```

## Inputs

- The argument after `$delete` is the program/package name, for example `tmux`.
- If the user names profiles, remove it only from those profiles.
- If no profile is named, remove it from every `custom.apps` list in `configurations/darwin/default.nix` and `configurations/nixos/default.nix`.
- If the user says Darwin/macOS only, target Darwin profiles only. If they say NixOS/Linux only, target NixOS profiles only.

## Workflow

1. Read `AGENTS.md`, `git status --short`, `flake.nix`, `configurations/darwin/default.nix`, `configurations/nixos/default.nix`, `modules/home_manager/default.nix`, and `modules/home_manager/packages/default.nix`.
2. Check whether `<name>` appears in any `custom.apps` list and whether it has a registry entry in `modules/home_manager/packages/default.nix`.
3. Remove `"<name>"` from the intended profile `custom.apps` lists. Do not touch unrelated profile entries.
4. After editing profiles, search all configuration files for remaining `"<name>"` references in `custom.apps`.
5. If no remaining profile uses `<name>`:
   - remove `<name> = [ ./<name> ];` from `modules/home_manager/packages/default.nix` if present;
   - delete `modules/home_manager/packages/<name>/default.nix` if it exists;
   - remove the package directory if it becomes empty.
6. If any profile still uses `<name>`, keep the registry entry and module file.
7. Validate with the lightest relevant command:
   - Darwin profile changed: `nix eval .#darwinConfigurations.<profile>.config.system.build.toplevel.drvPath`
   - NixOS profile changed: `nix eval .#nixosConfigurations.<profile>.config.system.build.toplevel.drvPath`
   - If many profiles changed, prefer `nix flake check --no-build` after targeted evals when practical.
   - If evaluation needs network or sandbox escalation, request approval and rerun.

## Editing Rules

- Use `apply_patch` for manual edits.
- Do not revert unrelated user changes.
- Preserve existing package/module style, including two-space Nix indentation.
- Deleting the package module is allowed only when no profile still references the app name.
- Be careful with similarly named packages, such as `openmp` versus `openmtp`; remove exact string matches only.
- If the requested package is not present anywhere, make no code changes and explain that it was already absent.

## Final Response

Report:

- The profiles the package was removed from.
- Whether the registry entry was removed or kept.
- Whether the package module was deleted or kept.
- The validation command and result, or why validation could not run.
