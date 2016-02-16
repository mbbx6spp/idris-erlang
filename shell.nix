{ pkgs ? import <nixpkgs> {}
, hscompiler ? "ghc7102"
, ... }:
let

  inherit (pkgs) stdenv erlang;

  hsenv   = pkgs.pkgs.haskell;
  hspkgsF = p: with p; [
    cabal-install
    doctest
    idris
  ];
  ghc = hsenv.packages.${hscompiler}.ghcWithPackages hspkgsF;

in
stdenv.mkDerivation {
  name = "funops-cli";
  buildInputs = [
    ghc
    erlang
  ];

  shellHook = ''
    eval $(grep export ${ghc}/bin/ghc)
  '';
}
