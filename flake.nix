{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    hackmatrix = {
      url = "github:collinalexbell/HackMatrix";
      flake = false;
    };
  };

  outputs = { self , nixpkgs ,... }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
        inherit system;
    };

    environment_packages = with pkgs; [
      dmenu
      zeromq
      xorg.libX11
      xorg.libXcomposite
      sqlite
      xorg.xwininfo
      xdotool
      protobuf
      spdlog
      assimp
      glfw
      xorg.libXfixes
      libglvnd
      xorg.libpthreadstubs
      xorg.libXtst
    ];
  in {
    packages."${system}" = {
      hackmatrix = pkgs.stdenv.mkDerivation {
       name = "hackmatrix";
       buildInputs = environment_packages;

      };
      default = self.outputs.packages."${system}".hackmatrix;
    };
  };
}

