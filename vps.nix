{
  modulesPath,
  ...
}:

{
  imports = [ (modulesPath + "/virtualisation/digital-ocean-config.nix") ];

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    optimise.automatic = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 8d";
    };
  };

  networking = {
    hostName = "jorgearayadev";
    firewall = {
      enable = true;
      allowedTCPPorts = [
        80
        443
      ];
    };
  };

  time.timeZone = "America/Costa_Rica";

  i18n.defaultLocale = "es_CR.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_CR.UTF-8";
    LC_IDENTIFICATION = "es_CR.UTF-8";
    LC_MEASUREMENT = "es_CR.UTF-8";
    LC_MONETARY = "es_CR.UTF-8";
    LC_NAME = "es_CR.UTF-8";
    LC_NUMERIC = "es_CR.UTF-8";
    LC_PAPER = "es_CR.UTF-8";
    LC_TELEPHONE = "es_CR.UTF-8";
    LC_TIME = "es_CR.UTF-8";
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "jorge+dns@esavara.cr";

    certs."jorgearaya.dev" = {
      webroot = "/var/lib/acme/acme-challenges";
    };
  };

  services.nginx = {
    enable = true;
    virtualHosts."jorgearaya.dev" = {
      enableACME = true;
      forceSSL = true;
      root = "/var/www/jorgearaya.dev";

      locations."/.well-known/acme-challenge/" = {
        root = "/var/lib/acme";
      };
    };
  };

  system.stateVersion = "24.11";
}
