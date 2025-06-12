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
      pkgs.openjpeg
      pkgs.mesa
      pkgs.glibc
    ]}"
    
    source venv/bin/activate
    python run.py
  '';
}
