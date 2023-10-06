{
  description = "A Nix-flake-based Go development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:

    utils.lib.eachDefaultSystem (system:
      let
        goVersion = 18;
        overlays = [ (final: prev: { 
          go = prev."go_1_${toString goVersion}";
        }) ];
        pkgs = import nixpkgs { inherit overlays system; };
      in
      {
        devShells.default = pkgs.mkShellNoCC {
          buildInputs = [
            ./sql-migrate
            # go 1.19 (specified by overlay)
            pkgs.go

            # goimports, godoc, etc.
            pkgs.gotools

            # https://github.com/golangci/golangci-lint
            pkgs.golangci-lint
          ];

          shellHook = ''
            ${pkgs.go}/bin/go version
          '';
        };
      });
}
