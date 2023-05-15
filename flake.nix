{
  description = "chainweb-node-2 flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    chainwebModule = {
      url = "github:kadena-io/chainweb-node-nixos-module/65e615972d9efa2987695ef4ac664d2430fb0a30";
    };

    chainwebNode = {
      url = "github:kadena-io/chainweb-node";
    };

    chainwebNodeCompaction = {
      url = "github:kadena-io/chainweb-node/c785deaf729968e0e8a7c7becc6761f029d7aa5b";
    };
  };

  outputs =
    { nixpkgs,
      home-manager,
      chainwebModule,
      chainwebNode,
      chainwebNodeCompaction,
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
          chainwebNodeCompaction.packages.x86_64-linux.default
        ];
      };

      packages."${system}".default =
        self.nixosConfigurations.chainweb-node.config.system.build.toplevel;
    };
}
