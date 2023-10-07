{ 
  pkgs ? import <nixpkgs> { system = builtins.currentSystem; },
  lib ? pkgs.lib,
  buildGoModule ? pkgs.buildGoModule,
  fetchFromGitHub ? pkgs.fetchFromGitHub
}:

buildGoModule rec {
  pname = "sql-migrate";
  version = "1.5.2";

  src = fetchFromGitHub {
    owner = "rubenv";
    repo = "sql-migrate";
    rev = "v${version}";
    sha256 = "sha256-nuVHeNiQdir8/FZNDz42wheGE1FFDPSO/CwvGQffN2E=";
  };

  proxyVendor = true; # darwin/linux hash mismatch
  vendorHash = "sha256-ZHnM3Wumsfg389nqt75/6BhhputNf4MtZxRKVAoHh6E=";

  meta = with lib; {
    description = "Database schema migration";
    license = licenses.mit;
    mainProgram = "sql-migrate";
  };
}
