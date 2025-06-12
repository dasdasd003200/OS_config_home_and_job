{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-23.11.tar.gz") {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    nodejs_20
    (pkgs.writeShellScriptBin "install-bun" ''
      curl -fsSL https://bun.sh/install | bash
    '')
  ];

  shellHook = ''
    echo "🚀 Entorno de desarrollo NestJS cargado 🚀"

    if ! command -v bun &> /dev/null; then
      curl -fsSL https://bun.sh/install | bash
      source ~/.bashrc
    fi

    export PATH="$HOME/.bun/bin:$PATH"
    
    # Instalar NestJS CLI si no está presente
    if ! command -v nest &> /dev/null; then
      bun add -g @nestjs/cli
    fi

    export NODE_OPTIONS=--max_old_space_size=4096
  '';
}
