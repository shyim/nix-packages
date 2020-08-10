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
  version = "2020.1.4";
  description = "Professional IDE for Web and PHP developers";
  license = stdenv.lib.licenses.free;
  src = fetchurl {
    url = "https://download.jetbrains.com/webide/PhpStorm-2020.1.4.tar.gz";
    sha256 =
      "1jfxa9ndbhjcdpb1i7f00vvjhzg2d6chzfxb58gxzj1vz7sj4fd2";
  };
  wmClass = "jetbrains-phpstorm";
  update-channel = "PhpStorm RELEASE";
}
