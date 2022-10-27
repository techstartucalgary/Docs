{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable-small";
  };

  outputs = inputs: let
    system = "x86_64-linux";

    nixpkgs = import inputs.nixpkgs {inherit system;};

    dependencies = [
      nixpkgs.mdbook
      nixpkgs.mdbook-linkcheck
    ];
  in {
    devShells.${system}.default = nixpkgs.mkShell {
      name = "docs";
      packages = dependencies;
    };

    packages.${system}.default = nixpkgs.stdenv.mkDerivation {
      name = "docs";
      src = ./.;

      buildInputs = dependencies;

      buildPhase = "mdbook build --dest-dir $out";
      dontInstall = true;
    };
  };
}
