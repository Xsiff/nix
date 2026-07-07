{ pkgs, ... }:
{
  # Basic system settings for NixOS
  
  # Enable networking
  networking.networkmanager.enable = true;
  
  # Set time zone (adjust to your preference)
  time.timeZone = "America/New_York";
  
  # Internationalization
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  
  # Console settings
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };
  
  # Enable sound with pipewire (modern alternative to PulseAudio)
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  
  # Enable the X11 windowing system (optional - remove if using Wayland only)
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    xkb.variant = "";
  };
  
  # System packages that should always be available
  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    git
  ];
}
