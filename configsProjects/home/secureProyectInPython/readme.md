Para q funcion 1ro usar el comando de instalacion una vez

nix-shell install.nix

Luego ya podemos usar el

nix-shell run.nix

# Env Secure

# MongoDB Settings

# MONGODB_HOST=192.168.16.17

# MONGODB_PORT=27019

# MONGODB_USERNAME=emv-prod

# MONGODB_PASSWORD=**\*\***

# MONGODB_REPLICA_SET=rs0

# DATABASE_NAME=zSecure

# MONGODB_HOST=192.168.16.18

# MONGODB_PORT=27019

# MONGODB_USERNAME=emv-prod

# MONGODB_PASSWORD=**\*\*\*\***

# MONGODB_REPLICA_SET=rs0

# DATABASE_NAME=zSecure

MONGODB_HOST=192.168.16.32
MONGODB_PORT=27018
MONGODB_USERNAME=emv-prod-admin
MONGODB_PASSWORD=**\***
MONGODB_REPLICA_SET=rs0
DATABASE_NAME=zSecure

# JWT Settings (para autenticación)

JWT_SECRET_KEY=**\***
JWT_ALGORITHM=HS256
ACCESS_TOKEN_EXPIRE_MINUTES=30
REFRESH_TOKEN_EXPIRE_DAYS=7

# Server Settings

SERVER_HOST=0.0.0.0
SERVER_PORT=8080

# Logging

LOG_LEVEL=INFO

# Google OAuth2 Settings (para autenticación con Google)

GOOGLE_CLIENT_ID=****\*\*****\*\*****\*\*****
GOOGLE_CLIENT_SECRET=****\*\*****\*\*\*\*****\*\*****

# #Google reCAPTCHA

# RECAPTCHA_SECRET_KEY=**\*\***\*\*\*\***\*\***

GOOGLE_CLIENT_ID=\***\*\*\*\*\***\*\*\*\*\***\*\*\*\*\***
GOOGLE_CLIENT_SECRET=**\*\*\***

# #Google reCAPTCHA

RECAPTCHA_SECRET_KEY=**\***

# Frontend URL (en producción)

FRONTEND_URL=http://localhost:4200
#FRONTEND_URL=https://zyrax.tech

# Security (CORS Configuración)

CORS_ALLOW_ORIGINS=http://localhost:4200,https://zyrax.tech,https://secure.zyrax.tech,https://studio.apollographql.com
CORS_ALLOW_CREDENTIALS=True
CORS_ALLOW_METHODS=GET,POST,PUT,DELETE,OPTIONS,PATCH
CORS_ALLOW_HEADERS=Content-Type,Authorization,X-User-Agent-Data,apollographql-client-name,apollographql-client-version,Accept,Accept-Version,Content-Length,Content-MD5,X-Auth-Token,X-Requested-With,Origin

# Email Service

EMAIL_SERVICE_URL=https://email.zyrax.tech/graphql
EMAIL_SERVICE_API_KEY=your_email_service_api_key_here

# gRPC Configuración (si es necesario)

GRPC_SERVER_HOST=0.0.0.0
GRPC_SERVER_PORT=50052
SERVICE_MAIL_GRPC_HOST=0.0.0.0
SERVICE_MAIL_GRPC_PORT=50053

# 2FA Settings (Autenticación de 2 factores)

OTP_SECRET_KEY=your_otp_secret_key_here
OTP_DIGITS=6
OTP_INTERVAL=30

# Password Reset (Restablecimiento de Contraseña)

PASSWORD_RESET_TOKEN_EXPIRE_HOURS=24

# Rate Limiting (Limitación de Tasa de Peticiones)

RATE_LIMIT_REQUESTS=100
RATE_LIMIT_PERIOD_SECONDS=60

# Session Management (Gestión de Sesiones)

SESSION_COOKIE_NAME=session_token
SESSION_COOKIE_SECURE=True
SESSION_COOKIE_HTTPONLY=True
SESSION_COOKIE_SAMESITE=Lax

# Encryption (Cifrado)

FERNET_KEY=your_fernet_encryption_key_here

# Development Settings (Configuraciones de Desarrollo)

DEBUG=False
TESTING=False

# Security (CORS Configuración)

# Orígenes permitidos - Agregados más dominios por seguridad

CORS_ALLOW_ORIGINS=http://localhost:4200,https://zyrax.tech,https://www.zyrax.tech,https://secure.zyrax.tech,https://api.zyrax.tech,https://studio.apollographql.com

# Credenciales y métodos

CORS_ALLOW_CREDENTIALS=true
CORS_ALLOW_METHODS=GET,POST,PUT,DELETE,OPTIONS,PATCH,HEAD

# Headers permitidos - Ampliados para cubrir más casos

CORS_ALLOW_HEADERS=Accept,Accept-Version,Access-Control-Allow-Headers,Access-Control-Allow-Methods,Access-Control-Allow-Origin,Access-Control-Request-Headers,Access-Control-Request-Method,Authorization,Cache-Control,Content-Length,Content-MD5,Content-Type,DNT,Host,Origin,Pragma,Referer,User-Agent,X-Auth-Token,X-Requested-With,X-User-Agent-Data,apollographql-client-name,apollographql-client-version

# CORS_ALLOW_HEADERS=Content-Type,Authorization,X-User-Agent-Data,apollographql-client-name,apollographql-client-version,Accept,Accept-Version,Content-Length,

# Content-MD5,X-Auth-Token,X-Requested-With,Origin

# Headers expuestos

CORS_EXPOSE_HEADERS=Content-Length,Content-Type,Authorization,X-Request-ID,Access-Control-Allow-Origin,Access-Control-Allow-Credentials

# Configuración adicional de seguridad

CORS_MAX_AGE=3600
CORS_ALLOW_PRIVATE_NETWORK=true
CORS_PREFLIGHT_MAX_AGE=86400
