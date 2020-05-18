{ nixpkgs ? import <nixpkgs> { }, stdenv ? nixpkgs.stdenv
, fetchFromGitHub ? nixpkgs.fetchFromGitHub }:

stdenv.mkDerivation rec {
  name = "shopware-docker";
  version = "2020-01-27";
  dontPatchShebangs = true;

  src = fetchFromGitHub {
    owner = "shyim";
    repo = "shopware-docker";
    rev = "0f445ca971e98d7707e8b5b2a6b3661bf172110e";
    sha256 = "0sqr1znk36p5fr4bwhqbzp692l9plwbchpnij67p5yskb15q6lsb";
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
