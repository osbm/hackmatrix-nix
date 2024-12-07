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
      spdlog
    ];
  in {
    packages."${system}" = {
      hackmatrix = pkgs.stdenv.mkDerivation {
       name = "hackmatrix";
       buildInputs = environment_packages;
       src = pkgs.fetchFromGitHub {
         owner = "collinalexbell";
	 repo = "HackMatrix";
	 rev = "v1.stable";
	 fetchSubmodules = true;
	 sha256 = "sha256-SBx2If5zxybyzrB+jMR2lkXWzePpqugKn/NppUCCstQ=";
       };
      };
      default = self.outputs.packages."${system}".hackmatrix;
    };
  };
}

