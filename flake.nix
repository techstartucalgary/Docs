{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable-small";
  };

  outputs = inputs: let
    system = "x86_64-linux";

    nixpkgs = import inputs.nixpkgs {inherit system;};
  in {
    devShells.${system}.default = nixpkgs.mkShell {
      name = "tsu-resources";
      packages = [
        nixpkgs.mdbook
      ];
    };
  };
}
