{ nixpkgs ? import <nixpkgs> { }, stdenv ? nixpkgs.stdenv
, fetchFromGitHub ? nixpkgs.fetchFromGitHub }:

stdenv.mkDerivation rec {
  name = "shopware-docker";
  version = "2019-11-09";
  patchShebangs = false;

  src = fetchFromGitHub {
    owner = "shyim";
    repo = "shopware-docker";
    rev = "8d345a9f5d4c7c8278bb8af2d5213a5e540a48d8";
    sha256 = "1ga5b1ljbvg4s4p8gxb9r24hxlxx31nvmc6451v97ghpksra7bkq";
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
