Para q funcion 1ro usar el comando de instalacion una vez

nix-shell install.nix

Luego ya podemos usar el

nix-shell run.nix

## Mail variables

GMAIL_SENDER_NAME=Empresa Metalúrgica Vinto
GMAIL_USER=soporte@zyrax.tech
GMAIL_APP_PASSWORD=mllq oucw olgs ablq

# GMAIL_USER=soporte@emvinto.com

# GMAIL_APP_PASSWORD=ikqj rjrk grgo zmqh

#create add password https://myaccount.google.com/apppasswords

## Graphql variables

GRAPHQL_SERVER_HOST=127.0.0.1 # Can be overridden to 0.0.0.0 in production
GRAPHQL_SERVER_PORT=2525

## gRPC variable

GRPC_SERVER_HOST=127.0.0.1 # Can be overridden to 0.0.0.0 in production
GRPC_SERVER_PORT=50053

# Security

CORS_ALLOW_ORIGINS=https://localhost:4200/ ,https://zyrax.tech/
#CORS_ALLOW_ORIGINS=_
CORS_ALLOW_CREDENTIALS=True
CORS_ALLOW_METHODS=GET,POST,PUT,DELETE,OPTIONS
CORS_ALLOW_HEADERS=_
#developer .env
