{ lib, buildGoModule, fetchFromGithub }:

buildGoModule rec {
  pname = "sql-migrate";
  version = "1.5.2";

  src = fetchFromGithub {
    owner = "rbenv";
    repo = "sql-migrate";
    rev = "v${version}";
  };

  meta = with lib; {
    mainProgram = "sql-migrate";
  };
}
