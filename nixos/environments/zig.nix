# NIX_DEBUG=1 clang -E -x c - -v

let
  pkgs = import <nixpkgs> {};
  stdenv = pkgs.stdenv;
in rec {
  zigEnv = stdenv.mkDerivation rec {
    name = "zig-env";
    version = "1.0";
    src = "./.";
    buildInputs = with pkgs; [
      llvm
      clang
      cmake
    ];
    shellHook = ''
      export CC=clang
      export CXX=clang++
    '';
  };
}
