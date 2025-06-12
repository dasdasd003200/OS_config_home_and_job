{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    nodejs_20
    bun
    nodePackages.npm
    nodePackages.typescript
    nodePackages."@nestjs/cli"
  ];

  shellHook = ''
    export NODE_OPTIONS=--max_old_space_size=4096
    bun run start:dev
  '';
}

