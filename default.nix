{ pkgs ? import <nixpkgs> {}, release ? "1.36.0", platform ? "x86_64-linux", binary ? "dhall" }:

let
  releases = builtins.fromJSON (builtins.readFile ./sources.json);
  asset = releases."${release}"."${platform}"."${binary}";
  src = pkgs.fetchurl {
    url = asset.url;
    sha256 = asset.sha256;
  };
in pkgs.stdenv.mkDerivation {
  name = binary;
  phases = [ "unpackPhase" "installPhase" ];
  installPhase = ''
    mkdir -p $out/bin
    cp ${binary} $out/bin
  '';
  inherit src;
}
