{ pkgs ? import <nixpkgs> {} }:

let
  pythonWithPackages = pkgs.python3.withPackages (ps: with ps; [
    pip
    virtualenv
    setuptools
  ]);
in
pkgs.mkShell {
  buildInputs = [
    pythonWithPackages
    pkgs.git
    pkgs.openssl
    pkgs.swig
    pkgs.gcc
    pkgs.gnumake
    pkgs.zlib
    pkgs.libxml2
    pkgs.libxslt
  ];

  # Environment variables for proper building
  LDFLAGS = "-L${pkgs.openssl.out}/lib -L${pkgs.zlib.out}/lib";
  CFLAGS = "-I${pkgs.openssl.dev}/include -I${pkgs.libxml2.dev}/include/libxml2";

  shellHook = ''
    # Create and activate a virtual environment
    if [ ! -d "venv" ]; then
      python -m venv venv
    fi
    source venv/bin/activate

    # Install essential build tools first
    pip install --upgrade pip setuptools wheel

    # Clone PyKCS11 repository if not exists
    if [ ! -d "PyKCS11" ]; then
      echo "Cloning PyKCS11 repository..."
      git clone https://github.com/LudovicRousseau/PyKCS11.git
    fi

    # Build and install PyKCS11 directly using setup.py with Nix's SWIG
    cd PyKCS11
    echo "Building PyKCS11 from source..."
    SWIG="${pkgs.swig}/bin/swig" \
    CFLAGS="$CFLAGS" \
    LDFLAGS="$LDFLAGS" \
    python setup.py install --force
    cd ..

    # Install endesive and all dependencies in one go
    # Using --no-build-isolation to prevent pip from trying to rebuild PyKCS11
    pip install --no-build-isolation endesive

    # Verification
    if python -c "import PyKCS11; print('PyKCS11 version:', getattr(PyKCS11, '__version__', 'unknown'))"; then
      echo "PyKCS11 verification passed"
    else
      echo "ERROR: PyKCS11 verification failed"
      exit 1
    fi

    echo ""
    echo "--------------------------------------------------"
    echo "Environment successfully set up with:"
    echo " - PyKCS11 built from source"
    echo " - endesive and all dependencies installed"
    echo "--------------------------------------------------"
    echo "Type 'deactivate' to exit the virtual environment"
    echo "--------------------------------------------------"
  '';
}

