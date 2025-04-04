{ stdenv, fetchurl }:
  stdenv.mkDerivation rec {
    pname = "sddm-sugar-candy-theme";
    version = "1.0";
    src = fetchurl {
    url = "https://github.com/Melechtna/nixos-sddm-themes/raw/SugarCandy-Background/sugar-candy.tar.gz";
    sha256 = "1a8690fbb00e2183fdc99ce3d38d93fc4c0c8e1e23deb6f678294b418c70e486";
  };

    dontConfigure = true;
    dontBuild = true;

    installPhase = ''
      runHook preInstall

      mkdir -p $out/share/sddm/themes/
      tar -xvf $src -C $out/share/sddm/themes/

      runHook postInstall
    '';
  }
