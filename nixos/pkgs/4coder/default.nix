{stdenv, libX11, libXfixes, unzip}:
stdenv.mkDerivation {
  name = "4coder";
  src = ./4coder-linux-64-alpha-4-0-1-super.zip;

  libPath = stdenv.lib.makeLibraryPath [
    libX11
    libXfixes
  ];

  buildInputs = [ unzip ];

  phases = [ "unpackPhase" "installPhase" ];
  installPhase = ''
    mkdir -p "$out/opt/"
    cp -r * "$out/opt/"
    chmod +x "$out/opt/4ed"

    patchelf --set-interpreter $(cat $NIX_CC/nix-support/dynamic-linker) \
      --set-rpath "$libPath" "$out/opt/4ed"

    mkdir "$out/bin"
    ln -s "$out/opt/4ed" "$out/bin/4ed"
  '';
}
