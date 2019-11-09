{ stdenv, lib, fetchurl, makeWrapper }:

stdenv.mkDerivation rec {
  name = "frp";
  version = "0.29.1";

  src = fetchurl {
    url =
      "https://github.com/fatedier/frp/releases/download/v0.29.1/frp_0.29.1_linux_amd64.tar.gz";
    sha256 = "055zw9kh58pxf61qjkdmll21swrhn1x2kb1nl1sv7jbk522r9mlq";
  };

  nativeBuildInputs = [ makeWrapper ];
  dontBuild = true;

  installPhase = ''
    mkdir -p $out/share/frp/bin
    cp frpc frps $out/share/frp/bin
    makeWrapper $out/share/frp/bin/frpc $out/bin/frpc
    makeWrapper $out/share/frp/bin/frps $out/bin/frps
  '';

  meta = {
    homepage = "https://github.com/fatedier/frp";
    description =
      "A fast reverse proxy to help you expose a local server behind a NAT or firewall to the internet.";
    maintainers = with lib.maintainers; [ shyim ];
    license = lib.licenses.asl20;
    platforms = with lib.platforms; unix;
  };
}