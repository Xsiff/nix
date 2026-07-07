# NixOS Configuration

This directory contains NixOS configurations that mirror the structure of the Darwin configurations.

## Key Differences from Darwin

### System Configuration
- Uses `nixpkgs.lib.nixosSystem` instead of `nix-darwin.lib.darwinSystem`
- Platform is `x86_64-linux` or `aarch64-linux` instead of `aarch64-darwin`
- State version uses NixOS versioning (e.g., "24.05") instead of Darwin's numeric version

### User Management
- Users are created with `isNormalUser = true`
- Home directory is `/home/username` instead of `/Users/username`
- Users need to be added to groups like `wheel`, `networkmanager`, `docker`, etc.

### System Settings
NixOS includes additional system settings not present in Darwin:
- Network configuration (NetworkManager)
- Sound system (PipeWire)
- X11/Wayland display server
- Locale and timezone settings
- Console configuration

### Removed Darwin-Specific Features
- No dock settings (macOS specific)
- No application alias script (macOS `/Applications` folder)
- No Colima (macOS Docker alternative - use native Docker on Linux)

## Available Configurations

1. **DesktopFull**: Full desktop setup with all applications
   - Apps: vscode, spotify, htop, uv, cursor, tex-live, docker, zsh

2. **DesktopStandard**: Standard desktop for everyday use
   - Apps: cursor, spotify, vscode, uv

3. **DesktopMinimal**: Minimal setup with just system essentials
   - Apps: none (only system packages)

## Setup Instructions

### 1. Generate Hardware Configuration

On your NixOS system, generate the hardware configuration:

```bash
sudo nixos-generate-config --show-hardware-config > hardware-configuration.nix
```

Move this file to `configurations/nixos/hardware-configuration.nix`

### 2. Uncomment Hardware Import

In `configurations/nixos/default.nix`, uncomment the hardware configuration import:

```nix
./hardware-configuration.nix
```

### 3. Adjust Settings

Edit `modules/nixos/default.nix`:
- Change `nixpkgs.hostPlatform` to match your architecture:
  - `"x86_64-linux"` for Intel/AMD 64-bit
  - `"aarch64-linux"` for ARM 64-bit (e.g., Raspberry Pi 4)
- Adjust `system.stateVersion` to match your NixOS version

Edit `modules/nixos/system_settings.nix`:
- Set your correct timezone
- Adjust locale settings if needed
- Modify keyboard layout if not using US layout

### 4. Build and Switch

Build your configuration:

```bash
# For DesktopFull configuration
sudo nixos-rebuild switch --flake .#DesktopFull

# For DesktopStandard configuration
sudo nixos-rebuild switch --flake .#DesktopStandard

# For DesktopMinimal configuration
sudo nixos-rebuild switch --flake .#DesktopMinimal
```

## Customization

### Adding Applications

Add apps to the `custom.apps` list in `configurations/nixos/default.nix`:

```nix
DesktopFull = mkNixOSConfig username { 
  custom.apps = [ "vscode" "spotify" "your-new-app" ]; 
};
```

Make sure the corresponding package module exists in `modules/home_manager/packages/`.

### Changing Username

Update the `username` variable at the top of `configurations/nixos/default.nix`:

```nix
username = "your-username";
```

### System-wide vs User Packages

- **System packages** go in `modules/nixos/system_settings.nix` under `environment.systemPackages`
- **User packages** are managed through Home Manager and the `custom.apps` option

## Architecture Notes

The NixOS configuration follows the same modular approach as the Darwin configuration:

```
configurations/nixos/
├── default.nix           # Main entry point with configuration variants
└── README.md             # This file

modules/nixos/
├── default.nix           # Core NixOS system setup
├── app_options.nix       # Custom app options definition
└── system_settings.nix   # Basic system configuration
```

Home Manager modules are shared between Darwin and NixOS configurations, located in `modules/home_manager/`.
