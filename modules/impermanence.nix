{ inputs, config, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.frontear.impermanence;
in {
  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];

  options.frontear.impermanence.enable = mkEnableOption "impermanence module";

  config = mkIf cfg.enable {
    environment.persistence."/nix/persist".directories = [ "/etc/machine-id" ];
  };
}
