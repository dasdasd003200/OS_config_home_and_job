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
    python -m venv venv
    source venv/bin/activate
    pip install --upgrade pip setuptools wheel
    pip install grpcio grpcio-tools
    pip install -r requirements.txt
    export LD_LIBRARY_PATH="${pkgs.stdenv.cc.cc.lib}/lib:$LD_LIBRARY_PATH"
    export LD_LIBRARY_PATH="${pkgs.zlib}/lib:$LD_LIBRARY_PATH"
  '';

  PYTHON_VERSION = "3.12";
}
