{ stdenv, fetchFromGitHub, rustPlatform, cmake, pkgconfig, zlib, openssl }:

with rustPlatform;

buildRustPackage rec {
  pname = "wrangler";
  version = "1.6.0";

  cargoSha256 = "1qw969vh3img92rw0wc0c768gysv2g5a0wr4qsdvbww4j61j4vsz";

  src = fetchFromGitHub {
    owner = "cloudflare";
    repo = "wrangler";
    rev = "v${version}";
    sha256 = "1rbjjyax6w87xdq722rndp3lhx9v70fcj8a9d6pbm9ys2x8r4xqs";
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
