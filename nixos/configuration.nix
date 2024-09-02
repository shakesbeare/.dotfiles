# Edit this configuration file to define what should be installed on
# your system.    Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
    system.stateVersion = "24.05"; # Did you read the comment?
    nix.settings.experimental-features = [ "nix-command" "flakes"];

    imports =
        [ # Include the results of the hardware scan.
        	./hardware-configuration.nix
        ];

    # Bootloader.
    boot.loader.systemd-boot.enable = false;

    boot.loader.grub.enable = true;
    boot.loader.grub.device = "nodev";
    boot.loader.grub.useOSProber = true;
    boot.loader.grub.efiSupport = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.efi.efiSysMountPoint = "/boot";

    networking.hostName = "nixos-dt"; # Define your hostname.
    # networking.wireless.enable = true;    # Enables wireless support via wpa_supplicant.

    # Enable networking
    networking.networkmanager.enable = true;

    # Set your time zone.
    time.timeZone = "America/Boise";

    # Select internationalisation properties.
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

    services.libinput = {
        enable = true;
        mouse = {
            accelProfile = "flat";
            accelSpeed = "+1.0";
        };
    };

    hardware.pulseaudio.enable = true;
    hardware.graphics.enable = true;

    services.xserver = {
        enable = true;
        dpi = 180;
        upscaleDefaultCursor = true;

        videoDrivers = [ "nvidia" ];

        xkb = {
            layout = "us";
            variant = "";
        };


        desktopManager = {
            xterm.enable = false;
        };
        
        windowManager.i3.enable = true;
    };

    services.displayManager = {
        defaultSession = "none+i3";
    };

    services.picom = {
        enable = true;
        shadow = true;
        settings = {
            shadow-radius = 20;
            round-borders = 20;
            corner-radius = 20;
        };
    };

    xdg.portal = {
        enable = true;
        # config = {
        #     common = {
        #         default = [ "kde" ];
        #     };
        # };
        extraPortals = [ pkgs.xdg-desktop-portal-kde ];
    };

    services.unclutter.enable = true; # hide mouse cursor when inactive

    hardware.nvidia.modesetting.enable = true;
    hardware.nvidia.open = true;

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.bmoffett = {
        isNormalUser = true;
	shell = pkgs.zsh;
        description = "Berint Moffett";
        extraGroups = [ "networkmanager" "wheel" ];
        packages = with pkgs; [];
    };

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
        pavucontrol
        gcc
    ];
    environment.variables = {
        XCURSOR_SIZE = "64";
    };
    environment.pathsToLink = [ "/libexec" ];
    fonts.packages = [
        inputs.fonts
    ];
    programs.zsh.enable = true;
    programs._1password.enable = true;
    programs._1password-gui = {
        enable = true;
        polkitPolicyOwners = [ "bmoffett" ];
    };
    programs.thunar.enable = true;

}
