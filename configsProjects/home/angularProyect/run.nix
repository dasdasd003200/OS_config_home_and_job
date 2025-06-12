{pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    nodejs_20
    nodePackages.npm
  ];

  shellHook = ''
    export NODE_OPTIONS=--max_old_space_size=4096
    export NPM_CONFIG_REGISTRY=https://registry.npmjs.org/
    export PATH="$HOME/.npm-global/bin:$PATH"
    ng serve --hmr
  '';
}

