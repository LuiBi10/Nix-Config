{
  description = "NixOS configuration with Zen Browser and Ghostty";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    ghostty.url = "github:ghostty-org/ghostty";
  };

  outputs = inputs@{ nixpkgs, home-manager, zen-browser, ghostty, ... }: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
{
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.luibi = import ./home.nix;
          }
          ({ pkgs, ... }: {
            environment.systemPackages = with pkgs; [
              ghostty.packages.x86_64-linux.ghostty
              zen-browser.packages.x86_64-linux.twilight

            ];
          })
        ];
      };
    };
  };
}

