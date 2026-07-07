# Nix-Darwin Configuration

Minimal nix-darwin and home-manager configuration for macOS.

## Structure

```
.
├── flake.nix                    # Main flake with inputs
├── configurations/
│   └── darwin/
│       ├── default.nix         # Darwin system configurations
│       └── scripts/
│           └── alias_script.nix # macOS app aliasing for Spotlight
└── modules/
    ├── darwin/                 # System-level settings
    └── home_manager/           # User-level settings
        └── packages/           # Individual package modules
```

## Profiles

Three profiles for different use cases:

- **`MacbookProMinimal`** - No packages (debugging)
- **`MacbookProStandard`** - Essential packages (default)
- **`MacbookProFull`** - All packages (testing)

## Usage

**Build and switch:**
```bash
darwin-rebuild switch --flake .#MacbookProStandard
```

**Update flake inputs:**
```bash
nix flake update
```

**Clean old generations:**
```bash
nix-collect-garbage -d
```

## Adding Packages

1. Create `modules/home_manager/packages/mypackage/default.nix`:
```nix
{ pkgs, ... }: {
  home.packages = [ pkgs.mypackage ];
}
```

2. Add import to `modules/home_manager/packages/default.nix`

3. Add to desired profile in `modules/home_manager/default.nix`

## Features

- Modular per-package configuration
- Profile system for different setups
- macOS app aliasing for Spotlight integration
- Username parameterization for multi-user support
