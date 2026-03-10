{
  description = "Quinyx tools - qlogtail and frontend-dev-relay";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    let
      # Version and hash data for qlogtail
      qlogtailVersion = "61.0.0";
      qlogtailHashes = {
        x86_64-linux = "8b837918d294243291e8af01f94a4a29897016ffe676cf59d37bd979f565721c";
        aarch64-linux = "f94808e5ae5c1c78f34b7b8d75b7c24fed220e03d716484089931ad2e46d7a28";
        x86_64-darwin = "2fa4205253eab45f1e821ae542f3fdf32b4ea30c2dc1633f4b344d5fb8812302";
        aarch64-darwin = "2bf3f63fa877972eef30cdfd0ebf6063b74d310bbe6c04fcbe05648c64571b86";
      };

      # Version and hash data for frontend-dev-relay
      frontendDevRelayVersion = "2.61.0";
      frontendDevRelayHashes = {
        x86_64-linux = "0853e10eb97c72b4557604dda3f6ed32edf974df764b957535aa7778ab773fd9";
        aarch64-linux = "5de3bc29ebffe2104ccbb51583928c8df12947183684e9c831859510b1e318cd";
        x86_64-darwin = "af2927c684285f7aec58fe0b16b368b20ae2ae2821456c7be96ce08deef1e552";
        aarch64-darwin = "c1a942cdface1c0acc854d3ea1f84b9f8276b9559656350e885cccf5d3d7a368";
      };

      # Map Nix system to download suffix
      systemToSuffix = {
        x86_64-linux = "linux_amd64";
        aarch64-linux = "linux_arm64";
        x86_64-darwin = "darwin_amd64";
        aarch64-darwin = "darwin_arm64";
      };

      # Supported systems
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];

    in
    flake-utils.lib.eachSystem supportedSystems (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        suffix = systemToSuffix.${system};

        qlogtail = pkgs.stdenv.mkDerivation {
          pname = "qlogtail";
          version = qlogtailVersion;

          src = pkgs.fetchurl {
            url = "https://github.com/quinyx/homebrew-tap/releases/download/v${qlogtailVersion}/qlogtail_${qlogtailVersion}_${suffix}.tar.gz";
            sha256 = qlogtailHashes.${system};
          };

          sourceRoot = ".";

          nativeBuildInputs = pkgs.lib.optionals pkgs.stdenv.isLinux [
            pkgs.autoPatchelfHook
          ];

          buildInputs = pkgs.lib.optionals pkgs.stdenv.isLinux [
            pkgs.stdenv.cc.cc.lib
          ];

          installPhase = ''
            runHook preInstall
            install -Dm755 qlogtail $out/bin/qlogtail
            runHook postInstall
          '';

          meta = with pkgs.lib; {
            description = "View Quinyx logs like a boss";
            homepage = "https://quinyx.com/";
            platforms = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
            mainProgram = "qlogtail";
          };
        };

        frontend-dev-relay = pkgs.stdenv.mkDerivation {
          pname = "frontend-dev-relay";
          version = frontendDevRelayVersion;

          src = pkgs.fetchurl {
            url = "https://github.com/quinyx/homebrew-tap/releases/download/v${frontendDevRelayVersion}/frontend-dev-relay_${frontendDevRelayVersion}_${suffix}.tar.gz";
            sha256 = frontendDevRelayHashes.${system};
          };

          sourceRoot = ".";

          nativeBuildInputs = pkgs.lib.optionals pkgs.stdenv.isLinux [
            pkgs.autoPatchelfHook
          ];

          buildInputs = pkgs.lib.optionals pkgs.stdenv.isLinux [
            pkgs.stdenv.cc.cc.lib
          ];

          installPhase = ''
            runHook preInstall
            install -Dm755 frontend-dev-relay $out/bin/frontend-dev-relay
            runHook postInstall
          '';

          meta = with pkgs.lib; {
            description = "Powerup Frontend workflow, no more waiting for Backend to deliver";
            homepage = "https://quinyx.com/";
            platforms = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
            mainProgram = "frontend-dev-relay";
          };
        };

      in {
        packages = {
          inherit qlogtail frontend-dev-relay;
          default = qlogtail;
        };
      }
    ) // {
      # Overlay for use in NixOS/Home Manager configurations
      overlays.default = final: prev: {
        qlogtail = self.packages.${prev.system}.qlogtail;
        frontend-dev-relay = self.packages.${prev.system}.frontend-dev-relay;
      };

      # Home Manager modules
      homeManagerModules = {
        qlogtail = { config, lib, pkgs, ... }:
          let
            cfg = config.programs.qlogtail;
          in {
            options.programs.qlogtail = {
              enable = lib.mkEnableOption "qlogtail - View Quinyx logs like a boss";
            };

            config = lib.mkIf cfg.enable {
              home.packages = [ self.packages.${pkgs.system}.qlogtail ];
            };
          };

        frontend-dev-relay = { config, lib, pkgs, ... }:
          let
            cfg = config.programs.frontend-dev-relay;
          in {
            options.programs.frontend-dev-relay = {
              enable = lib.mkEnableOption "frontend-dev-relay - Powerup Frontend workflow";
            };

            config = lib.mkIf cfg.enable {
              home.packages = [ self.packages.${pkgs.system}.frontend-dev-relay ];
            };
          };

        # Combined module for all Quinyx tools
        default = { config, lib, pkgs, ... }:
          let
            cfg = config.programs.quinyx;
          in {
            options.programs.quinyx = {
              qlogtail.enable = lib.mkEnableOption "qlogtail - View Quinyx logs like a boss";
              frontend-dev-relay.enable = lib.mkEnableOption "frontend-dev-relay - Powerup Frontend workflow";
            };

            config = lib.mkMerge [
              (lib.mkIf cfg.qlogtail.enable {
                home.packages = [ self.packages.${pkgs.system}.qlogtail ];
              })
              (lib.mkIf cfg.frontend-dev-relay.enable {
                home.packages = [ self.packages.${pkgs.system}.frontend-dev-relay ];
              })
            ];
          };
      };

      # NixOS modules
      nixosModules = {
        qlogtail = { config, lib, pkgs, ... }:
          let
            cfg = config.programs.qlogtail;
          in {
            options.programs.qlogtail = {
              enable = lib.mkEnableOption "qlogtail - View Quinyx logs like a boss";
            };

            config = lib.mkIf cfg.enable {
              environment.systemPackages = [ self.packages.${pkgs.system}.qlogtail ];
            };
          };

        frontend-dev-relay = { config, lib, pkgs, ... }:
          let
            cfg = config.programs.frontend-dev-relay;
          in {
            options.programs.frontend-dev-relay = {
              enable = lib.mkEnableOption "frontend-dev-relay - Powerup Frontend workflow";
            };

            config = lib.mkIf cfg.enable {
              environment.systemPackages = [ self.packages.${pkgs.system}.frontend-dev-relay ];
            };
          };

        # Combined module for all Quinyx tools
        default = { config, lib, pkgs, ... }:
          let
            cfg = config.programs.quinyx;
          in {
            options.programs.quinyx = {
              qlogtail.enable = lib.mkEnableOption "qlogtail - View Quinyx logs like a boss";
              frontend-dev-relay.enable = lib.mkEnableOption "frontend-dev-relay - Powerup Frontend workflow";
            };

            config = lib.mkMerge [
              (lib.mkIf cfg.qlogtail.enable {
                environment.systemPackages = [ self.packages.${pkgs.system}.qlogtail ];
              })
              (lib.mkIf cfg.frontend-dev-relay.enable {
                environment.systemPackages = [ self.packages.${pkgs.system}.frontend-dev-relay ];
              })
            ];
          };
      };
    };
}
