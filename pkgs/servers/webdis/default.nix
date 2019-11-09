{ lib, nixpkgs ? import <nixpkgs> { }, stdenv ? nixpkgs.stdenv, fetchgit
, libevent }:

stdenv.mkDerivation rec {
  name = "webdis";
  version = "0.1.7";

  buildInputs = [ libevent.dev ];
  src = fetchgit {
    url = "https://github.com/nicolasff/webdis";
    rev = "fd4ff04ea44b3f386d59ffc36330880aed4437d5";
    sha256 = "1hwdmasdr09zlm2pw91wygc87xq2gyg8mi0lb8yqm5nimw5vnzpq";
  };

  installPhase = ''
    mkdir -p $out/bin
    mv webdis $out/bin
  '';
}
