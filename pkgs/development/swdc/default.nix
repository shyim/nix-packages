{ nixpkgs ? import <nixpkgs> { }, stdenv ? nixpkgs.stdenv
, fetchFromGitHub ? nixpkgs.fetchFromGitHub }:

stdenv.mkDerivation rec {
  name = "shopware-docker";
  version = "2019-11-28";
  dontPatchShebangs = true;

  src = fetchFromGitHub {
    owner = "shyim";
    repo = "shopware-docker";
    rev = "cd353f90e450a2e520aad89ad37afdf09871bea8";
    sha256 = "08wjgg6w48543dgfcv8zh0hapdbzvfg42bavgwjzpmgn85wmpzhf";
  };

  installPhase = ''
    mkdir -p $out/lib
    mkdir -p $out/bin
    cp -r . $out/lib
    echo "#!/usr/bin/env bash" > $out/bin/swdc
    echo "bash $out/lib/swdc \"\$@\"" >> $out/bin/swdc
    chmod +x $out/bin/swdc
  '';

}
