{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable-small";
  };

  outputs = inputs: let
    system = "x86_64-linux";

    nixpkgs = import inputs.nixpkgs {inherit system;};

    mdbook = [
      nixpkgs.mdbook
      nixpkgs.mdbook-linkcheck
    ];
    secretsManagementWorkshop = [
      nixpkgs.age
      nixpkgs.git-crypt
      nixpkgs.sops
      nixpkgs.vault
    ];
  in {
    devShells.${system}.default = nixpkgs.mkShell {
      name = "docs";
      packages = mdbook ++ secretsManagementWorkshop;
    };

    packages.${system}.default = nixpkgs.stdenv.mkDerivation {
      name = "docs";
      src = ./.;

      buildInputs = mdbook;

      buildPhase = "mdbook build --dest-dir $out";
      dontInstall = true;
    };
  };
}
