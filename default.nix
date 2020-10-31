{ pkgs ? import <nixpkgs> {}, release ? "1.36.0", platform ? "x86_64-linux", name ? "dhall" }:

let
  releases = builtins.fromJSON (builtins.readFile ./sources.json);
  asset = releases."${release}"."${platform}"."${name}";
  src = pkgs.fetchurl asset;
in pkgs.stdenv.mkDerivation {
  inherit name src;
  phases = [ "unpackPhase" "installPhase" ];
  installPhase = ''
    mkdir -p $out/bin
    cp * $out/bin
  '';
}
