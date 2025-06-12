{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.python312
    pkgs.python312Packages.pip
    pkgs.python312Packages.virtualenv
    pkgs.grpc
    pkgs.protobuf
    pkgs.stdenv.cc.cc.lib
    pkgs.zlib
    pkgs.glibc
    pkgs.cmake
    pkgs.pkg-config
  ];

  shellHook = ''
    source venv/bin/activate
    export LD_LIBRARY_PATH="${pkgs.stdenv.cc.cc.lib}/lib:$LD_LIBRARY_PATH"
    export LD_LIBRARY_PATH="${pkgs.zlib}/lib:$LD_LIBRARY_PATH"
    python main.py
  '';

  PYTHON_VERSION = "3.12";
}
