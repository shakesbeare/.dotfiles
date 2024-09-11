# Edit this configuration file to define what should be installed on
# your system.    Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, master-pkgs, ... }:

{
    system.stateVersion = "24.05"; # Did you read the comment?
    nix.settings.experimental-features = [ "nix-command" "flakes"];

    imports =
        [ # Include the results of the hardware scan.
        	./nixos-dt-hardware.nix
            ./cross-platform.nix
        ];

    # Bootloader.
    boot.loader.systemd-boot.enable = false;

    boot.loader.grub.enable = true;
    boot.loader.grub.device = "nodev";
    boot.loader.grub.useOSProber = true;
    boot.loader.grub.efiSupport = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.efi.efiSysMountPoint = "/boot";
    boot.extraModulePackages = with config.boot.kernelPackages; [
        v4l2loopback
    ];
    boot.extraModprobeConfig = ''
        options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    '';

    security.polkit.enable = true;
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

    hardware.graphics.enable = true;

    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
    };

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
    };

    services.displayManager.sddm.enable = true;
    services.displayManager.sddm.wayland.enable = true;
    services.displayManager.defaultSession = "hyprland";

    xdg.portal = {
        enable = true;
        # config = {
        #     common = {
        #         default = [ "kde" ];
        #     };
        # };
        extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
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
        autotiling
        master-pkgs.xdg-desktop-portal-hyprland
        wl-clipboard
        v4l-utils
    ];
    environment.variables = {
        XCURSOR_SIZE = "64";
        NIXOS_OZONE_WL = "1";
    };
    environment.pathsToLink = [ "/libexec" ];
    programs.zsh.enable = true;
    programs.thunar.enable = true;
    programs.hyprland = {
        package = master-pkgs.hyprland;
        portalPackage = master-pkgs.xdg-desktop-portal-hyprland;
        enable = true;
        xwayland.enable = true;
    };
}
