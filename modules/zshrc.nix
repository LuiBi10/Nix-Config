{ config, lib, pkgs, ... }:

let
  plugins = [
    "git"
    "colored-man-pages"
    "command-not-found"
  ];
in
{
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = plugins;  # Only standard Oh My Zsh plugins here
      theme = "";  # Disable Oh My Zsh theme to let Starship control the prompt
    };

    # Enable autosuggestions and syntax highlighting
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;

    # Aliases
    shellAliases = {
      hyp         = "sudo -E nvim /etc/nixos/modules/hyprland.nix";
      zh         = "sudo -E nvim /etc/nixos/modules/zshrc.nix";
      way         = "nvim ~/.config/waybar/config.jsonc";
      wallconfig  = "nvim ~/.config/hypr/hyprpaper.conf";
      home        = "sudo -E nvim /etc/nixos/home.nix";
      flake       = "sudo -E nvim /etc/nixos/flake.nix";
      conf        = "sudo -E nvim /etc/nixos/configuration.nix";
      garbage     = "sudo nix-collect-garbage -d";
      build       = "sudo nixos-rebuild switch";
      cat         = "bat --theme=base16";
      ls          = "eza --icons=always --color=always -a";
      ll          = "eza --icons=always --color=always -la";
      change      = "hyprctl dispatch exit";
      reload      = "source ~/.zshrc && echo 'Reloaded ~/.zshrc'";
      shut        = "sudo shutdown now";
      y           = "yazi";
    };

    # Starship prompt
    initExtra = ''
      # Environment Variables
      export VISUAL="nvim"
      export EDITOR="nvim"
      export PATH="$HOME/.local/bin:/usr/local/opt:/usr/bin:$PATH"
      export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"
      export SUDO_PROMPT="Deploying root access for %u. Password pls: "
      export BAT_THEME="base16"
      export PATH="$PATH:$HOME/.cargo/bin"

      # Bindkeys
      bindkey '^I' autosuggest-accept
      bindkey -M viins 'jk' vi-cmd-mode

      # History settings
      HISTFILE=~/.zhistory
      HISTSIZE=5000
      SAVEHIST=5000
      HISTDUP=erase
      setopt appendhistory
      setopt sharehistory
      setopt hist_ignore_space
      setopt hist_ignore_all_dups
      setopt hist_save_no_dups
      setopt hist_find_no_dups
      setopt extended_history
      setopt inc_append_history

      # Command not found handler
      command_not_found_handler() {
        printf "%s%s? I don't know what that is\n" "$acc" "$1" >&2
        return 127
      }

      # Startup utilities
      eval "$(zoxide init zsh)"
      eval "$(zellij setup --generate-auto-start zsh)"

      # Atuin
      if command -v atuin &> /dev/null; then
        eval "$(atuin init zsh)"
      fi

      # Krabby
     # krabby name charizard -s

      # Starship Prompt
      eval "$(starship init zsh)"
    '';
  };
}

