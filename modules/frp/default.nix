{ config, lib, pkgs, ... }:

with lib;

let
  inherit (lib) generators;
  cfg = config.services.frp;

in {
  options.services.frp = {
    enable = mkEnableOption "frp";
    config = mkOption { type = types.nullOr types.attrs; };
  };

  config = mkIf cfg.enable (mkMerge [{
    systemd.services.frp = let
      frpConfig = pkgs.writeText "frps.ini" (generators.toINI { } (cfg.config));
    in {
      enable = true;
      wantedBy = [ "multi-user.target" ];
      after = [ "network-online.target" ];
      serviceConfig = {
        User = "root";
        ExecStart = "${pkgs.shyim.frp}/bin/frps --config ${frpConfig}";
      };
    };
  }]);
}
