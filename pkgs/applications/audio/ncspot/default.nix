{ lib, fetchFromGitHub, rustPlatform, pkg-config, ncurses, openssl, python3, xorg, dbus
, withALSA ? true, alsaLib ? null
, withPulseAudio ? false, libpulseaudio ? null
, withPortAudio ? false, portaudio ? null
}:

rustPlatform.buildRustPackage rec {
  pname = "ncspot";
  version = "0.1.1";

  src = fetchFromGitHub {
    owner = "hrkfdn";
    repo = "ncspot";
    rev = "v${version}";
    sha256 = "0ldisr45w6ys1j62qv99ssqfg5q9dwrrzxh2maggyrx1zqdlsk6m";
  };

  cargoSha256 = "0k765hinqxfm30li1z66m1chsv69v6hiz109q2zlkxzg937qbnjh";

  cargoBuildFlags = [ "--features" "pulseaudio_backend,mpris" ];

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [ ncurses openssl libpulseaudio python3 xorg.libxcb dbus ];

  doCheck = false;

  meta = with lib; {
    description = "Cross-platform ncurses Spotify client written in Rust, inspired by ncmpc and the likes";
    homepage = "https://github.com/hrkfdn/ncspot";
    license = licenses.bsd2;
  };
}