# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nixpkgs.config = {
    allowUnfree = true;

    chromium = {
      enablePepperFlash = true;
      enableWideVine = true;
    };

    packageOverrides = pkgs: with pkgs; {
      keepasshttp = callPackage ./pkgs/keepasshttp/default.nix { };
      keepass = keepass.override {
        # TODO: Not even on unstable yet
        # plugins = [ pkgs.keepasshttp ];
      };
    };
  };

  # Use the gummiboot efi boot loader.
  boot.loader.gummiboot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "lapheater";
    networkmanager.enable = true;
  };

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "dk";
    defaultLocale = "en_DK.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/Copenhagen";

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "dk";
    xkbOptions = "eurosign:e";
    synaptics = {
      enable = true;
      twoFingerScroll = true;
    };
    windowManager = {
      i3.enable = true;
      default = "i3";
    };
    displayManager = {
      sessionCommands = with pkgs; ''
        ${i3status}/bin/i3status &
        ${networkmanagerapplet}/bin/nm-applet &
        ${coreutils}/bin/sleep 30 && ${dropbox}/bin/dropbox &
        ${redshift}/bin/redshift -l 55.7:12.6 -t 5700:3600 -g 0.8 -m randr &
      '';
    };
    desktopManager.xterm.enable = false;
  };

  environment.systemPackages = with pkgs; [
    # WM stuff
    i3status
    dmenu
    rxvt_unicode-with-plugins

    # Networking
    networkmanagerapplet

    # Editors
    emacs

    # Utils
    git
    wget

    # Stuff
    dropbox
    chromium
    keepass
    redshift
    keepasshttp
  ];

  programs.bash.enableCompletion = true;

  fonts = {
    enableCoreFonts = true;
    enableFontDir = true;
    enableGhostscriptFonts = false;

    fonts =  [
      # TODO: Currently only on unstable
      #pkgs.font-droid
    ];
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.kiljacken = {
    isNormalUser = true;
    description = "Emil Lauridsen";
    extraGroups = ["wheel" "networkmanager" "video" "audio" "power"];
    uid = 1000;
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "15.09";
}
