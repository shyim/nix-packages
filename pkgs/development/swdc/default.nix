{ nixpkgs ? import <nixpkgs> { }, stdenv ? nixpkgs.stdenv
, fetchFromGitHub ? nixpkgs.fetchFromGitHub }:

stdenv.mkDerivation rec {
  name = "shopware-docker";
  version = "2020-01-27";
  dontPatchShebangs = true;

  src = fetchFromGitHub {
    owner = "shyim";
    repo = "shopware-docker";
    rev = "569dcc2498c84f3847cf3e994d7dbdb69a54bdf1";
    sha256 = "05sigln1qk12vyzzxp7ms40x8id3f8si1y9w2hm0gr6pb24myl2g";
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
