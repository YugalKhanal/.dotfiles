# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # ./vm.nix
      # ./gpu-passthrough.nix
    ];

  # Bootloader.
  boot.kernelPackages = pkgs.linuxPackages_latest;
  # boot.zfs.enabled = true;

  boot.loader.grub = {
    enable = true;
    version = 2;
    efiSupport = true; # Enable UEFI support
    device = "nodev"; # No specific device for UEFI
  };

  boot.loader.efi = {
    canTouchEfiVariables = true; # Allows writing to UEFI variables
  };

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  # networking.networkmanager.userControl.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  # services.displayManager.sddm.enable = true;
  # services.desktopManager.plasma6.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "gb";
    variant = "mac";
  };


  # Configure console keymap
  console.keyMap = "uk";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Update your Bluetooth configuration
  hardware.bluetooth = {
    enable = true;
  };

  # Make sure the Bluetooth service starts up properly
  services.blueman.enable = true;

  # Add the DBus service configuration
  # services.dbus.enable = true;
  # services.dbus.packages = [ pkgs.bluez ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  virtualisation.docker.enable = true;

  # Enable sound with pipewire.
  # sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
    wireplumber.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.yugalkhanal = {
    isNormalUser = true;
    description = "yugalkhanal";
    extraGroups = [ "networkmanager" "wheel" "wireshark" "docker"];
    packages = with pkgs; [
      #  thunderbird
    ];
    shell = pkgs.zsh;
  };

  # Setting nerdfont

  # fonts.packages = with pkgs;[
  #   # JetBrainsMono
  #   (nerdfonts.override {fonts = ["JetBrainsMono"];})
  # ];

  # Install firefox.
  # programs.firefox.enable = true;
  programs.wireshark.enable = true;
  programs.steam = {
    enable = true;
    protontricks.enable = true;
  };
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    pkgs.lxqt.lxqt-archiver # GUI archive manager that works well with Wayland
    pkgs.zip
    pkgs.unzip
    pkgs.gnumake
    pkgs.vim
    pkgs.wget
    pkgs.neovim
    pkgs.firefox
    pkgs.alacritty
    pkgs.kitty
    pkgs.brave
    pkgs.tmux
    pkgs.git
    pkgs.inetutils
    pkgs.docker
    pkgs.gcc
    pkgs.clang
    pkgs.glib
    pkgs.go
    pkgs.lua
    pkgs.nodejs_22
    pkgs.python3
    pkgs.luajit
    pkgs.rustc
    pkgs.cargo
    pkgs.ripgrep
    pkgs.zsh
    pkgs.zathura
    pkgs.texliveFull
    pkgs.nmap
    pkgs.htop
    pkgs.fd
    pkgs.bat
    pkgs.fzf
    pkgs.lazygit
    pkgs.discord
    pkgs.yq
    pkgs.wireshark
    pkgs.libreoffice
    pkgs.fastfetch
    pkgs.xfce.thunar
    pkgs.waybar
    pkgs.spicetify-cli
    pkgs.yt-dlp
    pkgs.mpv
    pkgs.ncspot
    pkgs.transmission_4-gtk
    pkgs.wlogout
    pkgs.wttrbar
    pkgs.libnotify
    pkgs.swww
    pkgs.rofi-wayland
    pkgs.rofi-bluetooth
    pkgs.wofi
    pkgs.hyprlock
    pkgs.killall
    pkgs.OVMF
    # pkgs.blueman # bluetooth
    pkgs.bluez
    pkgs.bluez-tools
    pkgs.gtk2
    pkgs.gtk3
    pkgs.gtk4
    pkgs.grim
    pkgs.slurp
    pkgs.wl-clipboard
    pkgs.networkmanagerapplet
    pkgs.spotify
    pkgs.playerctl
    pkgs.banana-cursor
    pkgs.pavucontrol
    # pkgs.nm-connection-editor
  ];

  programs.hyprland = {
    enable = true;
    # nvidiaPatches = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    # If your cursor becomes invisible
    WLR_NO_HARDWARE_CURSORS = "1";
    # Hint electron apps to use wayland
    NIXOS_OZONE_WL = "1";
    XCURSOR_THEME = "banana-cursor";
    XCURSOR_SIZE = "24";
  };

  hardware = {
    # Opengl
    graphics.enable = true;
    # most wayland compositors need this
    nvidia.modesetting.enable = true;
    nvidia.open = true;
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;


  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
