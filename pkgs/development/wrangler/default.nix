{ stdenv, fetchFromGitHub, rustPlatform, cmake, pkgconfig, zlib, openssl }:

with rustPlatform;

buildRustPackage rec {
  pname = "wrangler";
  version = "1.5.0";

  cargoSha256 = "1dkfwlhz3xy16aghy9725xmbn8j844zjardfcgsnfrpsyyh40nsp";

  src = fetchFromGitHub {
    owner = "cloudflare";
    repo = "wrangler";
    rev = "v${version}";
    sha256 = "0h6cz7554g25jx4j9pjg8jw8x8fbvz08lbyrag8nsr0n31aal185";
  };

  nativeBuildInputs = [ cmake pkgconfig openssl.dev ];
  buildInputs = [ zlib ];

  outputs = [ "out" ];

  # Tests trying to create an folder which fails in /nix/store
  doCheck = false;

  meta = with stdenv.lib; {
    description = "wrangle your cloudflare workers";
    longDescription = ''
      wrangler is a CLI tool designed for folks who are interested in using Cloudflare Workers.
    '';
    homepage = "https://github.com/cloudflare/wrangler";
    license = licenses.mit;
    maintainers = with maintainers; [ shyim ];
  };
}
