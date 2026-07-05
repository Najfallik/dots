{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
     eza
     fzf
     fastfetch
     hwinfo
     wget
  ];
  # FZF zsh integration
  programs.fzf = {
    keybindings = true;
    fuzzyCompletion = true;
  };
  
  programs.zsh = {
    enable = true;
    histSize = 10000;
 	setOptions = [ "HIST_IGNORE_ALL_DUPS" "INC_APPEND_HISTORY" "SHARE_HISTORY" ];

    autosuggestions = {
      enable = true;
    };

    syntaxHighlighting = {
      enable = true;
      highlighters = [ "main" "brackets" ];
      };
    };
}
