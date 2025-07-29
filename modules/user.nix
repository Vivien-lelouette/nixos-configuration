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
      gimp
      unzip
      p7zip
      moonlight-qt
    ];
  };

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = false;
}
