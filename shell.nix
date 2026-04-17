{pkgs ? import <nixpkgs> {}}: let
  inherit (pkgs) mkShell opentofu sops;
in
  mkShell {
    packages = [
      opentofu
      sops
    ];
  }
