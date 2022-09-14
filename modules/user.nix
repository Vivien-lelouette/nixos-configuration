{ config, pkgs, ... }:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.vivien = {
    isNormalUser = true;
    description = "vivien";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [
      emacs
      vivaldi
      gimp
    ];
  };

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "vivien";
}