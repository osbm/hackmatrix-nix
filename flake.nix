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
          tracy
          xorg.xrandr
        ];
        src = pkgs.fetchFromGitHub {
          owner = "collinalexbell";
          repo = "HackMatrix";
          rev = "7f0cecb92ef7ec3d4d25ce4d55b5d4c9af09c76f";
          sha256 = "sha256-efReoUdINe70KCtjYvEBUySWSdvAkYJPUUwkql4lUjo=";
        };
      };
      default = self.outputs.packages."${system}".hackmatrix;
    };
  };
}
