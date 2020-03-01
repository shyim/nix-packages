{ lib, fetchFromGitHub, rustPlatform, pkg-config, ncurses, openssl, python3, xorg, dbus
, withALSA ? true, alsaLib ? null
, withPulseAudio ? false, libpulseaudio ? null
, withPortAudio ? false, portaudio ? null
}:

rustPlatform.buildRustPackage rec {
  pname = "ncspot";
  version = "0.1.2";

  src = fetchFromGitHub {
    owner = "hrkfdn";
    repo = "ncspot";
    rev = "v${version}";
    sha256 = "10jp2yh8jlvdwh297658q9fi3i62vwsbd9fbwjsir7s1c9bgdy8k";
  };

  cargoSha256 = "1gw8wvms1ry2shvm3c79wp5nkpc39409af4qfm5hd4wgz2grh8d2";

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
