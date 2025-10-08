{pkgs ? import <nixpkgs> {}}: let
  inherit (pkgs) mkShell opentofu;
in
  mkShell {
    packages = [
      opentofu
    ];
  }
