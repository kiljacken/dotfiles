# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  hostname = "devbox";
in
{
  imports =
    [ # Include the results of the hardware scan.
      (./machines + "/${hostname}.nix")
    ];

  nixpkgs.config = {
    allowUnfree = true;

    chromium = {
      enablePepperFlash = true;
      enableWideVine = true;
    };

    packageOverrides = pkgs: with pkgs; {
      i3 = stdenv.lib.overrideDerivation i3 (oldAttrs: rec {
        buildInputs = [ git ];
        # from nix-prefetch-git
        src = fetchgit {
          url = "http://github.com/Airblader/i3.git";
          rev = "3764415988e3c4377d252e3e00c961d784940b67";
          sha256 = "1qj5khsbsbss1xbq599v11mkqjswv3h1zcia86j2a6qsigjx1r8d";
        };
        # 3764415 = short git commit hash
        postUnpack = ''
            find .
            echo -n "4.12 (2016-03-03, branch \\\"gaps-next\\\")" > ./i3-3764415/I3_VERSION
            echo -n "4.12" > ./i3-3764415/VERSION
        '';
        # man doesn't get build, so don't try to copy?
        postInstall = ''
          wrapProgram "$out/bin/i3-save-tree" --prefix PERL5LIB ":" "$PERL5LIB"
          #mkdir -p $out/man/man1
          #cp man/*.1 $out/man/man1
          for program in $out/bin/i3-sensible-*; do
            sed -i 's/which/command -v/' $program
          done
        '';
      });
      #keepasshttp = callPackage ./pkgs/keepasshttp/default.nix { };
      #keepass = keepass.override {
      #  # TODO: Not even on unstable yet
      #  # plugins = [ pkgs.keepasshttp ];
      #};
    };
  };

  networking = {
    hostName = hostname;
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
    config = ''
      Section "InputClass"
          Identifier "touchpad"
          MatchIsTouchpad "on"
          Option "TapButton1" "1"
          Option "TapButton2" "3"
          Option "TapButton3" "2"
      EndSection
    '';
  };

  environment.systemPackages = with pkgs; [
    # WM stuff
    i3status
    dmenu
    rxvt_unicode-with-plugins
    xorg.xbacklight

    # Networking
    networkmanagerapplet

    # Editors
    emacs
    sublime3

    # Utils
    git
    subversion
    wget
    which
    xclip

    # Stuff
    dropbox
    chromium
    redshift
    # keepass
    # keepasshttp
  ];

  programs.bash.enableCompletion = true;

  fonts = {
    enableCoreFonts = true;
    enableFontDir = true;
    enableGhostscriptFonts = false;

    fonts =  [
      pkgs.font-droid
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
