{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-23.11.tar.gz") {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    nodejs_20
    nodePackages.npm
    (pkgs.writeShellScriptBin "install-bun" ''
      curl -fsSL https://bun.sh/install | bash
    '')
  ];
  
  shellHook = ''
    echo "🚀 Development Environment Loaded 🚀"
    
    # Instalar bun si no está presente
    if ! command -v bun &> /dev/null; then
      curl -fsSL https://bun.sh/install | bash
      source ~/.bashrc
    fi

    export PATH="$HOME/.bun/bin:$PATH"
    export NODE_OPTIONS=--max_old_space_size=4096
  '';
}
