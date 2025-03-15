{
  description = "NixOS configuration with Zen Browser, Ghostty, and JupyterLab";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    ghostty.url = "github:ghostty-org/ghostty";
  };

  outputs = inputs@{ nixpkgs, home-manager, zen-browser, ghostty, ... }: 
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          system = system;
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
                ghostty.packages.${system}.ghostty
                zen-browser.packages.${system}.twilight
              ];
            })
          ];
        };
      };

      # Add JupyterLab DevShell with Catppuccin theme support
      devShells.${system}.jupyterlab = pkgs.mkShell {
        buildInputs = with pkgs; [
          python3
          python3Packages.jupyterlab
          python3Packages.ipykernel  # Needed for Jupyter notebooks
          python3Packages.numpy
          python3Packages.pandas
          python3Packages.matplotlib
          python3Packages.scipy
          python3Packages.scikit-learn
          python3Packages.seaborn
          python3Packages.notebook  # Classic Jupyter Notebook
          nodejs  # Needed for installing JupyterLab themes
          yarn    # Helps manage JupyterLab extensions
        ];

        shellHook = ''
          echo "Welcome to your JupyterLab development environment!"
        '';
      };
    };
}

