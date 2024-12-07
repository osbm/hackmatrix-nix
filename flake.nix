{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };
  in {
    packages."${system}" = {
      hackmatrix = pkgs.stdenv.mkDerivation {
        name = "hackmatrix";
        buildInputs = with pkgs; [
          zeromq # libzmq
          xorg.libX11 # libX11
          xorg.libXcomposite # libXcomposite
          xorg.libXtst # libXtst
          xorg.libXext # libXext
          xorg.libXfixes # libXfixes
          protobuf # libprotobuf
          spdlog # spdlog
          # libfmt
          glfw # glfw
          libglvnd # libgl
          xorg.libpthreadstubs # libpthread
          assimp # assimp
          sqlite # libsqlite3
          xorg.xwininfo # x11-utils
          xdotool # xdotool
          protobufc # protobuf1
          # base-devel # already included in stdenv i think
        ];
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
