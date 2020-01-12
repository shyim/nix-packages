{ nixpkgs ? import <nixpkgs> { }, stdenv ? nixpkgs.stdenv
, fetchFromGitHub ? nixpkgs.fetchFromGitHub }:

stdenv.mkDerivation rec {
  name = "shopware-docker";
  version = "2020-01-10";
  dontPatchShebangs = true;

  src = fetchFromGitHub {
    owner = "shyim";
    repo = "shopware-docker";
    rev = "c568578e45b438876c58a17317d424c655a33a62";
    sha256 = "16l5ws0kg16za0ps0k0d21l001hi0vy6j8qfsjfhf4a5xd0l7kr5";
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
