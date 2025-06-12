Para q funcion 1ro usar el comando de instalacion una vez

nix-shell install.nix

Luego ya podemos usar el

nix-shell run.nix

Si no quiere funcionar o te pide endesive tienes q ponerlo individualemtne luego ya reconocer q ya lo tienes en tu venv

SECRET_KEY=supersecretkey
JWT_SECRET_KEY=Est3EsMISE3Dsecreto32s
JWT_ALGORITHM=HS256

ACCESS_TOKEN_EXPIRE_MINUTES=30
REFRESH_TOKEN_EXPIRE_DAYS=7

CELERY_BROKER_URL=redis://172.30.226.1:6379/0
CELERY_RESULT_BACKEND=redis://172.30.226.1:6379/0

# UPLOAD_FOLDER=uploads/

# KEYS_FOLDER=Keys

#STORAGE_ROOT=/home/dasdasd/Desktop/zEMV/dasdasd #
STORAGE_ROOT=/home/devdan/Desktop/zEMVv4/dasdasd #

#STORAGE_ROOT=/var/zephyrus/storage # Para producción

#MONGO_URI=mongodb://root:root@192.168.16.2:27017/?tls=false&directConnection=true
#MONGO_URI=mongodb://localhost:27017/?tls=false&directConnection=true

MONGODB_HOST=192.168.16.17
MONGODB_PORT=27019
MONGODB_USERNAME=emv-prod
MONGODB_PASSWORD=E7jYal22am,UmU4l/HS4>A|+GiK}(<CZPr0%i,WsI
MONGODB_REPLICA_SET=rs0

PORT=8000

CORS_ALLOWED_ORIGINS=http://localhost:4200,https://zyrax.tech,https://drive.zyrax.tech
CORS_ALLOWED_HEADERS=Content-Type,Authorization,X-File-Id,Content-Length
CORS_ALLOW_METHODS=GET,POST,PUT,DELETE,OPTIONS,PATCH
CORS_ALLOW_CREDENTIALS=True

WEBSOCKET_ORIGINS=http://localhost:4200,https://zyrax.tech,https://drive.zyrax.tech
WEBSOCKET_PATH=/upload
WEBSOCKET_NAMESPACE=/file
SOCKET_PING_TIMEOUT=5000
SOCKET_PING_INTERVAL=25000
