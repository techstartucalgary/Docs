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

    packages.${system}.default = nixpkgs.stdenv.mkDerivation {
      name = "tsu-resources";
      src = ./.;

      buildInputs = [nixpkgs.mdbook];

      builder = builtins.toFile "builder.sh" ''
        source $stdenv/setup

        for project in open-source-tutorial; do
          cd "$src/$project"
          mdbook build --dest-dir "$out/$project"
        done
      '';
    };
  };
}
