let
  nixpkgs = import <nixpkgs> {};
  lib = nixpkgs.lib;
  haskellPackages = (import /root/try/static-haskell-nix/survey/default.nix {}).haskellPackages;
  ghc = haskellPackages.ghc;
  pm36exe = nixpkgs.haskell.lib.justStaticExecutables haskellPackages.project-m36;
  inherit (nixpkgs) stdenv removeReferencesTo;
  pm36-no-ghc = stdenv.mkDerivation {
    name = "pm36-no-ghc";
    buildInputs = [pm36exe removeReferencesTo];
    unpackPhase = "true";
    installPhase = ''
      mkdir -p "$out/bin"
      cp ${pm36exe}/bin/project-m36-websocket-server $out/bin/
    '';
   preFixup = ''
     remove-references-to -t ${ghc} $out/bin/* 
   '';
  };
in pm36-no-ghc 
