{ config, pkgs, ... }:

{
  # Define the username and home directory
  home.username = "luibi";
  home.homeDirectory = "/home/luibi";
  home.stateVersion = "25.05";

  # Import additional configuration files if needed
  imports = [

  ];

  
  # Packages to be installed for the user
  home.packages = with pkgs; [
    
    # Web Browsers
    google-chrome       # Google Chrome browser

    # Customization Tools
    #catppuccin-gtk      # GTK theme based on Catppuccin
    dunst
    libsForQt5.qtstyleplugin-kvantum
    kdePackages.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    qt6Packages.qt6ct
    qt6.qtwayland
    qt5.qtwayland

    # Multimedia Tools
    ncspot              # Lightweight Spotify client for terminal
    mpv                # Media player with a minimalistic design
    yt-dlp          # Command-line tool for downloading videos from YouTube
    ani-cli             # Command-line tool for downloading anime

    #============= Communication and Social Networks
    discord             # Chat application for communities
    betterdiscordctl   # BetterDiscord installer
    mpris-scrobbler     # Scrobble music to Last.fm

    # Productivity Tools
    obsidian            # Markdown-based knowledge management tool
    zathura            # Document viewer with Vim-like keybindings
  
  #------------ Development Tools
    vscode              # Visual Studio Code (code editor)

    # Terminal and Shell Utilities
    tmux                # Terminal multiplexer
    tty-clock           # Terminal-based clock
    btop                # Resource monitor for terminal
    cava              # A simple and fast terminal-based audio player
    cmatrix             # Terminal-based matrix screensaver

    
    # Terminal Emulators
    alacritty           # Alacritty terminal emulator
    yazi               # Yazi terminal emulator
    starship          # Cross-shell prompt
  ];

  programs.git = {
    enable = true;
    userName = "Luibi";  # Replace with your name
    userEmail = "luferbrito96@gmail.com";  # Replace with your email
    extraConfig = {
      init.defaultBranch = "main";  # Default branch name
      pull.rebase = true;  # Rebase instead of merge on pull
      push.autoSetupRemote = true;  # Automatically set remote branch
    };
  };
}
