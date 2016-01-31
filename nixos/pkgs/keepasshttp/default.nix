{ stdenv, buildEnv, fetchurl, mono }:

let
  version = "1.8.4.0";
  drv = stdenv.mkDerivation {
    name = "keepasshttp-${version}";
    src = fetchurl {
      url = "https://github.com/pfn/keepasshttp/archive/${version}.tar.gz";
      sha256 = "03cdf442361c8284f4deb4f495240a77a19d1c29120e1d9efebd4df005cf1615";
    };

    meta = {
      description = "Keepass plugin providing access via an http api";
      homepage    = https://github.com/pfn/keepasshttp;
      platforms   = with stdenv.lib.platforms; linux;
      license     = stdenv.lib.licenses.gpl3;
    };

    pluginFilename = "KeePassHttp.plgx";

    installPhase = ''
      mkdir -p $out/lib/dotnet/keepass/
      cp $pluginFilename $out/lib/dotnet/keepass/$pluginFilename
    '';
  };
in
  # Mono is required to compile plugin at runtime, after loading.
  buildEnv { name = drv.name; paths = [ mono drv ]; }
