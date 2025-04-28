{ config, pkgs, ... }:

{
  # Import hardware configuration
  imports = [
    ./hardware-configuration.nix
  ];

  # Enable experimental Nix features for flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # Active virtualization virtualbox
   virtualisation.virtualbox.host.enable = true;
   users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];
   virtualisation.docker.enable = true;

  # Bootloader settings for system initialization
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Hostname and networking configuration
  networking.hostName = "nixos"; # Set the system hostname
  networking.networkmanager.enable = true; # Enable NetworkManager for managing connections

  # Timezone and localization settings
  time.timeZone = "America/Bogota"; # Set the timezone to Colombia
  i18n.defaultLocale = "en_US.UTF-8"; # Default locale in English
  i18n.extraLocaleSettings = {
  LC_ADDRESS = "en_US.UTF-8";
  LC_IDENTIFICATION = "en_US.UTF-8";
  LC_MEASUREMENT = "en_US.UTF-8";
  LC_MONETARY = "en_US.UTF-8";
  LC_NAME = "en_US.UTF-8";
  LC_NUMERIC = "en_US.UTF-8";
  LC_PAPER = "en_US.UTF-8";
  LC_TELEPHONE = "en_US.UTF-8";
  LC_TIME = "es_CO.UTF-8"; # Keep Colombian time format
  };

  # X server and desktop environment settings
  services.xserver.enable = true; # Enable the X server
  services.displayManager.sddm.enable = true; # Use SDDM as the display manager 
  services.displayManager.sddm.wayland.enable = true; # Enable Wayland support in SDDM
  services.desktopManager.plasma6.enable = true; # Enable KDE Plasma 6 desktop environment
  # Keyboard layout settings
  services.xserver.xkb = {
    layout = "us"; # Set the keyboard layout to US
    variant = ""; # Use the default variant
  };
  console.keyMap = "us"; # Set system-wide keyboard layout to US

  # Audio configuration using PipeWire instead of PulseAudio
  services.pulseaudio.enable = false; # Disable PulseAudio
  security.rtkit.enable = true; # Enable real-time kit for audio
  services.pipewire = {
    enable = true; # Enable PipeWire
    alsa.enable = true; # Enable ALSA support
    alsa.support32Bit = true; # Enable 32-bit ALSA support
    pulse.enable = true; # Enable PulseAudio compatibility
  };

  # services.plex = {
  #   enable = true;
  #   openFirewall = true;
  # };

  # User configuration for the system
  users.users.luibi = {
    isNormalUser = true; # Define as a regular user
    description = "luibi"; # User description
    extraGroups = [ "networkmanager" "wheel" "docker" ]; # Add to network and wheel groups
    packages = with pkgs; [];
  };

  # Default shell configuration
  programs.zsh.enable = true; # Enable Zsh as the shell
  users.defaultUserShell = pkgs.zsh; # Set Zsh as the default shell

  # Enable Firefox browser
  programs.firefox.enable = true; # Install and enable Firefox
  services.gvfs.enable = true; # Enable GVFS for better file system support

  # Allow installation of unfree packages
  nixpkgs.config.allowUnfree = true; # Enable unfree packages

  # Hyprland settings for Wayland compositor
  programs.hyprland.enable = true; # Enable Hyprland

  # Environment variables for theming and desktop consistency
  environment.variables = {
    GTK_THEME = "Breeze-Dark"; # Set Breeze-Dark as the GTK theme
    XDG_CURRENT_DESKTOP = "Hyprland"; # Set Hyprland as the current desktop
    QT_QPA_PLATFORM = "wayland"; # Set Wayland as the Qt platform
    QT_QPA_PLATFORMTHEME = "qt5ct"; # Set qt5ct as the platform theme
  };

  fonts.packages = with pkgs; [
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.nerd-fonts.iosevka
  ];

  # Activate the OpenSSH service
  services.openssh = {
  enable = true;
  ports = [ 22 ];
  settings = {
    PasswordAuthentication = true;
    AllowUsers = null; # Allows all users by default. Can be [ "user1" "user2" ]
    UseDns = true;
    X11Forwarding = false;
    PermitRootLogin = "prohibit-password"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
   };
  };
  
  networking.firewall.allowedTCPPorts = [ 22 ];
  
  # System packages
  environment.systemPackages = with pkgs; [

    # --- Development Tools ---
    neovim            # Neovim text editor
    gcc               # GNU Compiler Collection
    git               # Version control system
    python3           # Python programming language
    python312Packages.pip # Python package manager
    nodejs_22         # Node.js JavaScript runtime
    cargo             # Rust package manager
    python312Packages.ninja # Ninja build system
    python312Packages.jupyterlab # JupyterLab notebook
    python312Packages.debugpy # Python debugger
    lazygit           # Git terminal UI
    lua-language-server

    # --- Command-Line Utilities ---
    fzf               # Fuzzy finder for the terminal
    ripgrep           # Fast search tool
    jq                # JSON processor
    wget              # Command-line file downloader
    unzip             # Extract ZIP files
    curl              # URL downloader
    atuin             # Command-line shell history
    eza               # Enhanced 'ls' command
    bat               # 'cat' alternative with syntax highlighting
    zoxide            # Directory jumping tool
    zellij            # Terminal multiplexer

    # --- System & Performance Tools ---
    networkmanager    # Network connection manager
    polkit            # Authorization framework
    brightnessctl     # Control display brightness
    light             # Alternative brightness control
    wl-clipboard      # Wayland clipboard manager
    xclip             # Clipboard tool for X11
    hyprpolkitagent   # Polkit agent for Hyprland
    marksman          # Bookmark manager for the terminal
    home-manager      # Dotfile manager for NixOS       
    lua-language-server # Lua language server
    imagemagick          # Convert images
    tectonic             # Para renderizar expresiones LaTeX
    mermaid-cli          # Para diagramas Mermaid
    sqlite               # Para almacenamiento de frecency e historial
    ghostscript          # Render PDF files
    stylua               # Linter para Lua
    nwg-look            # GTK theme configurator

    # --- Audio & Multimedia ---
    pavucontrol       # PulseAudio volume control
    pamixer           # PulseAudio mixer
    playerctl         # Media player controller

    # --- GUI Applications & Desktop Enhancements ---
    kdePackages.qtsvg # Qt SVG library
    kdePackages.plasma-workspace
    xdg-desktop-portal-gtk   # Desktop portal for GTK apps
    xdg-desktop-portal-hyprland # Desktop portal for Hyprland

    # --- Hyprland & Wayland Setup ---
    hyprland         # Hyprland Wayland compositor
    waybar           # Status bar for Wayland
    hyprpaper        # Wallpaper manager for Hyprland
    rofi-wayland     # Rofi launcher for Wayland
    hyprshot         # Screenshot tool for Wayland

    # # --- Containers & Virtualization ---
    # docker           # Container runtime
    ];

  # System state version
  system.stateVersion = "25.05"; # Ensure compatibility with the current NixOS version

  # Bluetooth settings
  hardware.bluetooth.enable = true; # Enable Bluetooth
  hardware.bluetooth.powerOnBoot = true; # Power on Bluetooth at boot

   # Enable XDG portal services
   environment.etc."xdg/menus/applications.menu".source = 
  "/run/current-system/sw/etc/xdg/menus/plasma-applications.menu";

  # Interception Tools for dual-function keys
  services.interception-tools = {
    enable = true;
    plugins = [ pkgs.interception-tools-plugins.dual-function-keys ];
    udevmonConfig = ''
      - JOB: "${pkgs.interception-tools}/bin/intercept -g $DEVNODE | ${pkgs.interception-tools-plugins.dual-function-keys}/bin/dual-function-keys -c /etc/dual-function-keys.yaml | ${pkgs.interception-tools}/bin/uinput -d $DEVNODE"
        DEVICE:
          EVENTS:
            EV_KEY: [KEY_CAPSLOCK, KEY_ESC, KEY_LEFTCTRL]
    '';
  };

  environment.etc."dual-function-keys.yaml".text = ''
    TIMING:
    TAP_MILLISEC: 150
    DOUBLE_TAP_MILLISEC: 0

    MAPPINGS:
      - KEY: KEY_CAPSLOCK
        TAP: KEY_ESC
        HOLD: KEY_LEFTCTRL
  '';
}
