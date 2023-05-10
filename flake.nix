{
  description = "chainweb-node-2 flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    chainwebModule = {
      url = "github:kadena-io/chainweb-node-nixos-module/c008ee79f8c129677476d6c777f4aebb81809f9b";
    };

    chainwebNode = {
      url = "github:kadena-io/chainweb-node";
    };
  };

  outputs =
    { nixpkgs,
      home-manager,
      chainwebModule,
      chainwebNode,
      self,
      ...
    }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        chainweb-node = lib.nixosSystem {
          inherit system;

          modules =
            let
              main = import ./configuration.nix;
              homeManager = home-manager.nixosModules.home-manager;
              chainwebPackage = {
                nixpkgs.overlays = [
                  (self: super: {
                    chainweb-node = chainwebNode.packages.x86_64-linux.default;
                  })
                ];
              };
              chainwebService = chainwebModule.nixosModules.chainweb-node;
            in  
            [
              main
              homeManager
              chainwebPackage
              chainwebService
            ];
        };
      };

      devShell."${system}" = pkgs.mkShell {
        buildInputs = [
          chainwebNode.packages.x86_64-linux.default
        ];
      };

      packages."${system}".default =
        self.nixosConfigurations.chainweb-node.config.system.build.toplevel;
    };
}
