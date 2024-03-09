{ config, pkgs, ... }:
{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>

    # Provide an initial copy of the NixOS channel so that the user
    # doesn't need to run "nix-channel --update" first.
    <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
  ];

  # For unfree software
  nixpkgs.config.allowUnfree = true;

# if you use pulseaudio
  nixpkgs.config.pulseaudio = true;

  # KDE 5
  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  environment.plasma5.excludePackages = with pkgs.libsForQt5; [
    plasma-browser-integration
    konsole
    oxygen
  ];
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  environment.systemPackages = with pkgs; [
    neovim   
    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions; [
        bbenoist.nix

        redhat.vscode-xml
        redhat.vscode-yaml

        bradlc.vscode-tailwindcss

        ms-python.python
        ms-toolsai.jupyter

        ms-azuretools.vscode-docker

        prisma.prisma
        # yoavbls.pretty-ts-errors
        # expo.vscode-expo-tools
        dbaeumer.vscode-eslint
        # dsznajder.es7-react-js-snippets

        mikestead.dotenv

        # rvest.vs-code-prettier-eslint
        esbenp.prettier-vscode
        # mgmcdermott.vscode-language-babel

        unifiedjs.vscode-mdx

        ritwickdey.liveserver

        golang.go

        # equinusocio.vsc-material-theme-icons
        # rafaelmardojai.vscode-gnome-theme
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "remote-ssh-edit";
          publisher = "ms-vscode-remote";
          version = "0.47.2";
          sha256 = "1hp6gjh4xp2m1xlm1jsdzxw9d8frkiidhph6nvl24d0h8z34w49g";
        }
      ];
    })

    chromium
    libreoffice
  ];
}
