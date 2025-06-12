{ pkgs ? import <nixpkgs> {} }:

let
  # More complete URL encoding for password special characters
  password = "E7jYal22am,UmU4l/HS4>A|+GiK}(<CZPr0%i,WsI";
  encodedPassword = builtins.replaceStrings 
    [ "," ">" "<" "|" "+" "%" "}" "{" "(" ")" "/" ]
    [ "%2C" "%3E" "%3C" "%7C" "%2B" "%25" "%7D" "%7B" "%28" "%29" "%2F" ]
    password;
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    nodejs_20
    nodePackages.npm
  ];

  shellHook = ''
    echo "🚀 Mongo Express Environment Loading..."
    echo "Node.js version: $(node --version)"
    echo "npm version: $(npm --version)"
    
    if [ ! -d "node_modules" ] || [ ! -f "node_modules/.package-lock.json" ]; then
      echo "Installing dependencies..."
      rm -rf node_modules package-lock.json
      # Crear package.json con versiones específicas
      echo '{
        "dependencies": {
          "mongo-express": "1.0.0-alpha.4",
          "mongodb": "^4.17.1"
        }
      }' > package.json
      npm install
    fi
    
    # Using connection string directly for better control
    export ME_CONFIG_MONGODB_URL="mongodb://emv-prod-admin:${encodedPassword}@192.168.16.32:27018/admin?replicaSet=rs0"
    export ME_CONFIG_MONGODB_ENABLE_ADMIN="true"
    export ME_CONFIG_BASICAUTH_USERNAME=""
    export ME_CONFIG_BASICAUTH_PASSWORD=""
    
    # Configuración adicional para el driver
    export ME_CONFIG_MONGODB_AUTH_DATABASE="admin"
    export ME_CONFIG_MONGODB_ADMINUSERNAME="emv-prod-admin"
    export ME_CONFIG_MONGODB_ADMINPASSWORD="${encodedPassword}"
    
    echo "✅ Environment ready!"
    echo "Run 'npx mongo-express' to start the server"
    echo "Connection string will use the encoded password"

    npx mongo-express
    echo "====================="
  '';
}
