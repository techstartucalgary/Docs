{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable-small";
  };

  outputs = inputs: let
    system = "x86_64-linux";

    nixpkgs = import inputs.nixpkgs {inherit system;};
  in {
    devShells.${system}.default = nixpkgs.mkShell {
      name = "docs";
      packages = [
        nixpkgs.mdbook
      ];
    };

    packages.${system}.default = nixpkgs.stdenv.mkDerivation {
      name = "docs";
      src = ./.;

      buildInputs = [nixpkgs.mdbook];

      buildPhase = "mdbook build --dest-dir $out";
      dontInstall = true;
    };
  };
}
