# Quinyx Tools

Homebrew formulae and Nix flake for installing public Quinyx tools.

## Tools

### qlogtail
Tail Quinyx service logs like a boss.

### frontend-dev-relay
Powerup Frontend workflow, no more waiting for Backend to deliver.

---

## Installation

### Homebrew (macOS/Linux)

```bash
# Install qlogtail
brew install quinyx/tap/qlogtail

# Install frontend-dev-relay
brew install quinyx/tap/frontend-dev-relay
```

### Nix (direct)

```bash
# Run without installing
nix run github:quinyx/homebrew-tap#qlogtail -- --help
nix run github:quinyx/homebrew-tap#frontend-dev-relay

# Install to profile
nix profile install github:quinyx/homebrew-tap#qlogtail
nix profile install github:quinyx/homebrew-tap#frontend-dev-relay
```

### NixOS

Add the flake input to your `flake.nix`:

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    quinyx.url = "github:quinyx/homebrew-tap";
  };

  outputs = { nixpkgs, quinyx, ... }: {
    nixosConfigurations.your-hostname = nixpkgs.lib.nixosSystem {
      modules = [
        quinyx.nixosModules.default
        {
          programs.quinyx.qlogtail.enable = true;
          programs.quinyx.frontend-dev-relay.enable = true;
        }
      ];
    };
  };
}
```

Or use the overlay to add packages to `pkgs`:

```nix
{
  nixpkgs.overlays = [ quinyx.overlays.default ];
  environment.systemPackages = with pkgs; [
    qlogtail
    frontend-dev-relay
  ];
}
```

### Home Manager

#### With flakes (standalone or as NixOS module)

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    quinyx.url = "github:quinyx/homebrew-tap";
  };

  outputs = { nixpkgs, home-manager, quinyx, ... }: {
    homeConfigurations.your-username = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      modules = [
        quinyx.homeManagerModules.default
        {
          programs.quinyx.qlogtail.enable = true;
          programs.quinyx.frontend-dev-relay.enable = true;
        }
      ];
    };
  };
}
```

#### Adding packages directly

```nix
{ pkgs, inputs, ... }:
{
  home.packages = [
    inputs.quinyx.packages.${pkgs.system}.qlogtail
    inputs.quinyx.packages.${pkgs.system}.frontend-dev-relay
  ];
}
```

---

## Supported Platforms

| Platform | Architecture |
|----------|--------------|
| macOS    | Intel (x86_64), Apple Silicon (arm64) |
| Linux    | x86_64, arm64 |

## To Do

- [ ] **Automate Flake Updates:** Add a script or GitHub Action to automatically fetch the latest release versions and sha256 hashes from the GitHub API and update the `flake.nix` file when new versions of the tools are released.
