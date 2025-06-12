{ pkgs ? import <nixpkgs> {} }:

let
  pythonWithPackages = pkgs.python311.withPackages (ps: with ps; [
    pillow
    pip
    virtualenv
  ]);
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    pythonWithPackages
    pkg-config
    openssl.dev
    p11-kit.dev
    swig4
    zbar
    poppler
    poppler_utils
    ffmpeg
    mesa
    freetype.dev
    gcc
    stdenv.cc.cc.lib
    zlib
    glibc
    libtiff
    libjpeg
    libpng
    lcms2
    libwebp
    openjpeg
  ];

  shellHook = ''
    export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath [
      pkgs.stdenv.cc.cc.lib
      pkgs.zlib
      pkgs.openssl
      pkgs.p11-kit
      pkgs.zbar
      pkgs.freetype
      pkgs.libtiff
      pkgs.libjpeg
      pkgs.libpng
      pkgs.lcms2
      pkgs.libwebp
      pkgs.opnjpeg
      pkgs.mes
      pkgs.glibc
    ]}"

    if [ ! -d "venv" ]; then
      python -m venv venv
    fi
    source venv/bin/activate

    # No instalar Pillow via pip
    sed -i '/Pillow/d' requirements.txt
    pip install -r requirements.txt
    pip uninstall oscrypto -y
    pip install git+https://github.com/wbond/oscrypto.git@1547f535001ba568b239b8797465536759c742a3
  '';
}
