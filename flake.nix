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
      python312
      python312Packages.google-api-python-client
      python312Packages.google-auth-httplib2
      python312Packages.google-auth-oauthlib
    ];
  in {
    packages."${system}".hackmatrix = pkgs.stdenv {
      name = "hackmatrix";
      
    };

  };
}
