{ nixpkgs ? import <nixpkgs> {} }:
with nixpkgs.haskell.lib;
let
  inherit (nixpkgs)
    haskellPackages
    dockerTools
    busybox
    bash;
    pm36-no-ghc = import ./pm36-no-ghc.nix;
in
  dockerTools.buildImage {
    name = "pm36-on-heroku";
    tag = "latest";
    contents = [
      pm36-no-ghc
      busybox
      bash
    ];
    config = {
      Cmd = ["project-m36-websocket-server" "-n" "data"];
      WorkingDir = "/";
    };
  }
