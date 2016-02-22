let
  pkgs = import <nixpkgs> {};
  stdenv = pkgs.stdenv;
in rec {
  arkEnv = stdenv.mkDerivation rec {
    name = "ark-env";
    version = "1.0";
    src = "./.";
    buildInputs = with pkgs; [
      llvm
      clang
      go
      ncurses
      zlib
      glfw
      mesa_glu
      glew
    ];
  };
}
