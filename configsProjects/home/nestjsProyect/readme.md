Para q funcion 1ro usar el comando de instalacion una vez

nix-shell install.nix

solo una vez y poner dentro el nix
bun i

Luego ya podemos usar el

nix-shell run.nix

#-----------------------------------
PORT=5000

#-----------------------------------

# MONGODB_HOST=192.168.16.18

# MONGODB_PORT=27019

# MONGODB_USERNAME=emv-prod

# MONGODB_PASSWORD=E7jYal22am,UmU4l/HS4>A|+GiK}(<CZPr0%i,WsI

# MONGODB_REPLICA_SET=rs0

#Monguito produccion de producion
MONGODB_HOST=192.168.16.32
MONGODB_PORT=27018
MONGODB_USERNAME=emv-prod-admin
MONGODB_PASSWORD=E7jYal22am,UmU4l/HS4>A|+GiK}(<CZPr0%i,WsI
MONGODB_REPLICA_SET=rs0

# MONGODB_HOST=192.168.16.2

# MONGODB_PORT=27019

# MONGODB_USERNAME=root

# MONGODB_PASSWORD=root

# MONGODB_REPLICA_SET=rs0

#-----------------------------------
DB_URI_ZEPHYRUS=mongodb://root:root@192.168.22.44:27017/zephyrus?replicaSet=rs0 &
directConnection=true
DB_URI_ADSI=mongodb://root:root@192.168.22.44:27017/z-adsi?replicaSet=rs0 &
directConnection=true
DB_URI_SAREH=mongodb://root:root@192.168.22.44:27017/z-sareh?replicaSet=rs0 &
directConnection=true
DB_URI_SECURE=mongodb://root:root@192.168.22.44:27017/z-secure?replicaSet=rs0 &
directConnection=true
DB_URI_UDO=mongodb://root:root@192.168.22.44:27017/z-udo?replicaSet=rs0 &
directConnection=true
DB_URI_SALMA=mongodb://root:root@192.168.22.44:27017/z-salma?replicaSet=rs0 &
directConnection=true
DB_URI_GLOM=mongodb://root:root@192.168.22.44:27017/z-glom?replicaSet=rs0 &
directConnection=true

#-----------------------------------
DB_REPLICA_SET_ZEPHYRUS=rs0
DB_REPLICA_SET_ADSI=rs0
DB_REPLICA_SET_SAREH=rs0
DB_REPLICA_SET_SECURE=rs0
DB_REPLICA_SET_ZEPHYRUS=rs0
DB_REPLICA_SET_UDO=rs0
DB_REPLICA_SET_SALMA=rs0
DB_REPLICA_SET_GLOM=rs0

#-----------------------------------

# Mongoose Connection Options

USE_NEW_URL_PARSER=true
USE_UNIFIED_TOPOLOGY=true
POOL_SIZE=10
SERVER_SELECTION_TIMEOUT_MS=5000
SOCKET_TIMEOUT_MS=45000
FAMILY=4

#-----------------------------------

# Whitelist of allowed origins for CORS

ALLOWED_ORIGINS=http://localhost:4200,https://studio.apollographql.com/sandbox/explorer,https://studio.apollographql.com

#-----------------------------------

# Config

JWT_SECRET=Est3EsMISE3Dsecreto32s

#-----------------------------------

# Database Names (opcional, puedes mantenerlos en el código si prefieres)

DB_ADSI=zAdsi
DB_SAREH=zSareh
DB_SECURE=zSecure
DB_UDO=zUdo
DB_ZEPHYRUS=zephyrus
DB_SALMA=zSalma
DB_GLOM=zGlom
DB_ASSISTANT=zAssistant
