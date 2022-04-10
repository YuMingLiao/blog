# the path of this file is  ~/.config/nixpkgs/config.nix

{ pkgs ? import <nixpkgs> {}}:
with pkgs.haskell.lib;
{
  #android
  android_sdk.accept_license = true; 
  
  allowUnfree = true;
  allowBroken = true;
  packageOverrides = super: let self = super.pkgs; in
  rec {
    haskellPackages = haskell.packages.ghc8107;
    haskell = super.haskell // {
      packages = super.haskell.packages // {
       ghc8107 = super.haskell.packages.ghc8107.override {
         overrides = self: super: {
            #to all haskell packages.
            mkDerivation = drv: super.mkDerivation (drv // {doCheck = false; doHaddock = false; });          
            #for DynamicAtomFunctions without pattern match on Atom
            indextype = doJailbreak (self.callPackage /root/fix/indextype/indextype.nix {});
            constraint-manip = doJailbreak super.constraint-manip;
            polydata-core = doJailbreak super.polydata-core;
            polydata = doJailbreak super.polydata;
            heterolist = doJailbreak (self.callPackage /root/fix/heterolist/heterolist.nix {});
            tuple-hlist = doJailbreak (self.callPackage /root/fix/tuple-hlist/tuple-hlist.nix {});
            OneTuple = self.callPackage ./OneTuple-0.3.1.nix {};

            project-m36 = self.callPackage /root/project-m36-0.9/project-m36.nix {};
            #OneTuple bound
            universe-base = doJailbreak (self.callPackage ./universe-base-1.1.3.nix {});
            #@(Term -> a) becomes ViewPattern
            winery = doJailbreak (self.callPackage /root/fix/winery/winery.nix {});
            curryer-rpc = doJailbreak (self.callPackage ./curryer-rpc-0.2.1.nix {});
         };
       };
       #nix-static-haskell uses ghc8104
       ghc8104 = super.haskell.packages.ghc8104.override {
         overrides = self: super: {
            #to all haskell packages.
            mkDerivation = drv: super.mkDerivation (drv // {doCheck = false; doHaddock = false; });          
            curryer-rpc = doJailbreak (self.callPackage ./curryer-rpc-0.2.1.nix {});
            streamly = doJailbreak (self.callPackage ./streamly-0.8.1.1.nix {});
            unicode-data = self.callPackage ./unicode-data-0.3.0.nix {};
            project-m36 = self.callPackage /root/project-m36-0.9/project-m36.nix {};
          };
        };
      };
    };
  };
}

