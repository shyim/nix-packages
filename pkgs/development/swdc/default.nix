{ nixpkgs ? import <nixpkgs> { }, stdenv ? nixpkgs.stdenv
, fetchFromGitHub ? nixpkgs.fetchFromGitHub }:

stdenv.mkDerivation rec {
  name = "shopware-docker";
  version = "2019-11-28";
  dontPatchShebangs = true;

  src = fetchFromGitHub {
    owner = "shyim";
    repo = "shopware-docker";
    rev = "2817c1d0ae78c278d12cd649a001ddd1074dfef0";
    sha256 = "04jq9wwn7j6wbgfwrrlvz9m4wxfzkswwd0zw6h3k5df929y9qyfh";
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
