{ lib, stdenv, callPackage, fetchurl, python, jdk, cmake, libxml2, zlib, python3
, ncurses5 }:

with stdenv.lib;

let
  mkJetBrainsProduct = callPackage ./common.nix { };
  buildPhpStorm = { name, version, src, license, description, wmClass, ... }:
    (mkJetBrainsProduct {
      inherit name version src wmClass jdk;
      product = "PhpStorm";
      meta = with stdenv.lib; {
        homepage = "https://www.jetbrains.com/phpstorm/";
        inherit description license;
        longDescription = ''
          PhpStorm provides an editor for PHP, HTML and JavaScript
          with on-the-fly code analysis, error prevention and
          automated refactorings for PHP and JavaScript code.
        '';
        maintainers = with maintainers; [ schristo ];
        platforms = platforms.linux;
      };
    });

in buildPhpStorm rec {
  name = "phpstorm-${version}";
  version = "2019.2.5";
  description = "Professional IDE for Web and PHP developers";
  license = stdenv.lib.licenses.free;
  src = fetchurl {
    url = "https://download.jetbrains.com/webide/PhpStorm-${version}.tar.gz";
    sha256 =
      "079xiv4k44xkpyhp9fr7qdlkm9cvd39id0y7p6r1mfk1w60nqv7j";
  };
  wmClass = "jetbrains-phpstorm";
  update-channel = "PhpStorm RELEASE";
}
