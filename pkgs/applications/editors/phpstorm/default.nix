{ lib, stdenv, callPackage, fetchurl, python, jetbrains, cmake, libxml2, zlib, python3
, ncurses5 }:

with stdenv.lib;

let
  mkJetBrainsProduct = callPackage ./common.nix { };
  buildPhpStorm = { name, version, src, license, description, wmClass, ... }:
    (mkJetBrainsProduct {
      inherit name version src wmClass;
      product = "PhpStorm";
      jdk = jetbrains.jdk;
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
  version = "2020.3.1";
  description = "Professional IDE for Web and PHP developers";
  license = stdenv.lib.licenses.free;
  src = fetchurl {
    url = "https://download-cf.jetbrains.com/webide/PhpStorm-2020.3.1.tar.gz";
    sha256 =
      "1c5j3mbg8scsl4c90cjahdk5gs5q72y5a8fhkqa9zmy6di42k99x";
  };
  wmClass = "jetbrains-phpstorm";
  update-channel = "PhpStorm RELEASE";
}
