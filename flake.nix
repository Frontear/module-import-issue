{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.impermanence.url = "github:nix-community/impermanence";

  outputs = { self, nixpkgs, ... } @ inputs: {
    nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit self inputs;
      };

      modules = [
        ({ modulesPath, ... }: {
           imports = [
             "${modulesPath}/profiles/minimal.nix"
             self.nixosModules
           ];

           boot.loader.grub.enable = false;
           fileSystems."/".device = "nodev";
           nixpkgs.hostPlatform = "x86_64-linux";
           system.stateVersion = "24.11";
        })
      ];
    };

    nixosModules = import ./modules;
  };
}
