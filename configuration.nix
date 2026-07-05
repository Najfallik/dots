# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, ... }:

{

  nix.settings.substituters = [ "https://attic.xuyh0120.win/lantian" ];
  nix.settings.trusted-public-keys = [ "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc=" ];


  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./modules/nvidia.nix
      ./modules/fonts.nix
      ./modules/zsh/zsh.nix
	  ./modules/programming.nix      
#      ./modules/undervolt.nix // uncomment if you have intel-cpu that can be undervolted
    ];
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
#  nixpkgs.overlays = [
#  	inputs.nix-cachyos-kernel.overlays.pinned
#  ];
  
  # Bootloader.
  boot.loader.limine.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.limine.secureBoot.enable = true;
  boot.loader.limine.maxGenerations = 3;
  boot.loader.limine.style.interface.branding = "i use sikko's nix btw";

  # Use latest cachy kernel.
  boot.kernelPackages = inputs.nix-cachyos-kernel.legacyPackages.x86_64-linux.linuxPackages-cachyos-latest-lto-x86_64-v3;

  networking.hostName = "nix-btw"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Bratislava";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sk_SK.UTF-8";
    LC_IDENTIFICATION = "sk_SK.UTF-8";
    LC_MEASUREMENT = "sk_SK.UTF-8";
    LC_MONETARY = "sk_SK.UTF-8";
    LC_NAME = "sk_SK.UTF-8";
    LC_NUMERIC = "sk_SK.UTF-8";
    LC_PAPER = "sk_SK.UTF-8";
    LC_TELEPHONE = "sk_SK.UTF-8";
    LC_TIME = "sk_SK.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "sk";
    variant = "";
  };

services.scx = {
  enable = true;
  scheduler = "scx_lavd";
  extraArgs = [ "--autopilot" ];
};

  # Configure console keymap
  console.keyMap = "sk-qwertz";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."sikko" = {
    isNormalUser = true;
    description = "sikko";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  
  environment.systemPackages = with pkgs; [
  foot
  sbctl
  
  vesktop
  vscode
  
  wget
  curl
  git
  
  micro

  cmatrix
  btop
  fastfetch
  
  niri
  xwayland-satellite
  kdePackages.breeze

  inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
  inputs.helium-browser.packages.${pkgs.stdenv.hostPlatform.system}.default

  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  programs.zsh.enable = true;
  programs.niri.enable = true;
  services.greetd = {
  	enable = true;
  	settings = {
  		default_session = {
  			command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-user-session --cmd 'niri --session'";
  			user = "greeter";	
  		};
  	};
  };
  systemd.user.services.niri.enableDefaultPath = false;

  zramSwap = {
      enable = true;
      algorithm = "zstd";
      memoryPercent = 100;
      priority = 100;
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  
  xdg.portal = {
    enable = true;
	wlr.enable = false;
    xdgOpenUsePortal = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
    ];
    config = {
      common.default = [ "gnome" ];
    };
  };  
  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

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
  system.stateVersion = "26.05"; # Did you read the comment?

}
