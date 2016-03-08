let
  pkgs = import <nixpkgs> {};
  stdenv = pkgs.stdenv;
in rec {
  osdevEnv = stdenv.mkDerivation rec {
    name = "osdev-env";
    version = "1.0";
    src = "./.";
    buildInputs = with pkgs; [
      clang
      nasm
      qemu
    ];
  };
}
