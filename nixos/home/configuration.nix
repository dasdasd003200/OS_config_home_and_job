# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/La_Paz";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_BO.UTF-8";
    LC_IDENTIFICATION = "es_BO.UTF-8";
    LC_MEASUREMENT = "es_BO.UTF-8";
    LC_MONETARY = "es_BO.UTF-8";
    LC_NAME = "es_BO.UTF-8";
    LC_NUMERIC = "es_BO.UTF-8";
    LC_PAPER = "es_BO.UTF-8";
    LC_TELEPHONE = "es_BO.UTF-8";
    LC_TIME = "es_BO.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  
  #services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "latam";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "la-latin1";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dasdasd = {
    isNormalUser = true;
    description = "dasdasd";
    extraGroups = [ "networkmanager" "wheel" "docker" ];

    #añadir para el fish
    shell = pkgs.fish; 

    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;
 
  # Configuración de Fish para la terminal
 programs.fish = {
  enable = true;
  interactiveShellInit = ''
    # Configuración de thefuck
    set -U THEFUCK_OVERRIDDEN_ALIASES 1
    thefuck --alias | source

    # Configuración de fzf para mejorar el autocompletado
    set -U FZF_LEGACY_KEYBINDINGS 0
    set -U FZF_REVERSE_ISEARCH_OPTS "--reverse --height=100%"

    # Configuración para mejor visualización
    set fish_greeting ""
    set -U fish_term24bit 1

    # Configuración básica de tide (más segura)
    set -g tide_prompt_add_newline_before true
    set -g tide_prompt_color_separator_same_color 949494
    set -g tide_prompt_pad_items true

    # Aliases útiles para git
    abbr -a g git
    abbr -a ga 'git add'
    abbr -a gc 'git commit'
    abbr -a gco 'git checkout'
    abbr -a gp 'git push'
    abbr -a gpl 'git pull'
    abbr -a gs 'git status'
  '';
}; 

environment.variables = {
  TERMINAL = "tilix";
  TERM = "xterm-256color";
  # Estas variables ayudan con la renderización de fuentes
  GLYPHS = "1";
  COLORTERM = "truecolor";

  # Mantén las variables que ya tienes y añade estas
  PLASMA_USE_QT_SCALING = "1";
  QT_AUTO_SCREEN_SCALE_FACTOR = "0";
  NODE_OPTIONS = "--max-old-space-size=2048";
};

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #editor herrmientas basicas
    neovim
    vscode
    chromium
    mongodb-compass
    brave
    
    #herramientas de desarrollo
    git
    curl
    wget
    nerdfonts
    lazygit
    ripgrep
    dconf  
    tilix
    kitty
    gcc
    nodejs_22
    unzip
    python3
    nodePackages.prettier 
    fzf

    docker
    docker-compose
    
    #herramientas de compilacion
    
    #utilitarios
    xclip
    thefuck 
    
    # Plugins de Fish
    fishPlugins.tide
    fishPlugins.done
    fishPlugins.autopair
    fishPlugins.fzf
  
    # Herramientas de monitoreo
    bottom # Para monitoreo del sistema
    gdu    # Para análisis de uso de disco
   
    #para Optimizar recursos de la pc
    stacer    # Para gestión del sistema
    bleachbit # Para limpieza del sistema
    preload   # Mejora tiempos de carga

    #para la erminal logito
    neofetch
  ];
  
  #para packetes unfree 
  nixpkgs.config.allowUnfree = true;

  #copia del otro
  
  programs.nix-ld.enable = true;

  #fish conf
  environment.shells = with pkgs; [ fish ];

  #PARA OPTIMIZAR RECURSOS
  swapDevices = [{
   device = "/var/lib/swapfile";
   size = 8192; # 8GB swap
  }];

  boot.kernel.sysctl = {
   "vm.swappiness" = 10;
   "vm.vfs_cache_pressure" = 50;
   "vm.dirty_ratio" = 10;
   "vm.dirty_background_ratio" = 5;
   "vm.dirty_writeback_centisecs" = 1500;
   "kernel.nmi_watchdog" = 0;
  };  

  security.pam.loginLimits = [
   { domain = "*"; type = "soft"; item = "nofile"; value = "8192"; }
   { domain = "*"; type = "hard"; item = "nofile"; value = "16384"; }
   { domain = "*"; type = "soft"; item = "nproc"; value = "2048"; }
   { domain = "@users"; type = "soft"; item = "memlock"; value = "4096"; }
  ];

  systemd.extraConfig = ''
    DefaultTimeoutStopSec=10s
  '';

  #   Mejora el rendimiento gráfico
  services.xserver = {
    enable = true;
    deviceSection = ''
      Option "TearFree" "true"
      Option "DRI" "3"
    '';
  };

  # DOCKER CONFIG
  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = true;
      autoPrune.enable = true;  # Auto cleanup unused images/containers
    };
  };

  # Add docker group to your user (replace dasdasd with your username)
  #esta liena esta aumentada arriba
  # users.users.dasdasd.extraGroups = [ "networkmanager" "wheel" "docker" ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

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
  system.stateVersion = "24.11"; # Did you read the comment?

}

