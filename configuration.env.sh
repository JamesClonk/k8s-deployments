########################################################################################################################
####### ingress-nginx ##################################################################################################
########################################################################################################################
export INGRESS_DOMAIN="${INGRESS_DOMAIN:=example.org}" # for example "mydomain.org"
########################################################################################################################


########################################################################################################################
####### databases ######################################################################################################
########################################################################################################################
export POSTGRES_SUPERUSER_USERNAME="${POSTGRES_SUPERUSER_USERNAME:=username}"
export POSTGRES_SUPERUSER_PASSWORD="${POSTGRES_SUPERUSER_PASSWORD:=password}"
export POSTGRES_HOSTNAME="${POSTGRES_HOSTNAME:=hostname}"

export JCIO_MOVIEDB_HOST="${JCIO_MOVIEDB_HOST:=host}"
export JCIO_MOVIEDB_NAME="${JCIO_MOVIEDB_NAME:=dbname}"
export JCIO_MOVIEDB_USERNAME="${JCIO_MOVIEDB_USERNAME:=username}"
export JCIO_MOVIEDB_PASSWORD="${JCIO_MOVIEDB_PASSWORD:=password}"
export HOME_INFO_DB_HOST="${HOME_INFO_DB_HOST:=host}"
export HOME_INFO_DB_NAME="${HOME_INFO_DB_NAME:=dbname}"
export HOME_INFO_DB_USERNAME="${HOME_INFO_DB_USERNAME:=username}"
export HOME_INFO_DB_PASSWORD="${HOME_INFO_DB_PASSWORD:=password}"
export IR_VISUALIZER_DB_HOST="${IR_VISUALIZER_DB_HOST:=host}"
export IR_VISUALIZER_DB_NAME="${IR_VISUALIZER_DB_NAME:=dbname}"
export IR_VISUALIZER_DB_USERNAME="${IR_VISUALIZER_DB_USERNAME:=username}"
export IR_VISUALIZER_DB_PASSWORD="${IR_VISUALIZER_DB_PASSWORD:=password}"
########################################################################################################################


########################################################################################################################
####### jc.io ##########################################################################################################
########################################################################################################################
export JCIO_HTTP_HMAC_SECRET="${JCIO_HTTP_HMAC_SECRET:=secret}"
########################################################################################################################


########################################################################################################################
####### home-info ######################################################################################################
########################################################################################################################
export HOME_INFO_AUTH_USERNAME="${HOME_INFO_AUTH_USERNAME:=username}"
export HOME_INFO_AUTH_PASSWORD="${HOME_INFO_AUTH_PASSWORD:=password}"
export HOME_INFO_SLACK_TOKEN="${HOME_INFO_SLACK_TOKEN:=token}"
export HOME_INFO_TEAMS_WEBHOOK_URL="${HOME_INFO_TEAMS_WEBHOOK_URL:=http://example/deadbeef}"
########################################################################################################################


########################################################################################################################
####### irvisualizer ###################################################################################################
########################################################################################################################
export IR_VISUALIZER_LOGGLY_TOKEN="${IR_VISUALIZER_LOGGLY_TOKEN:=token}"
export IR_VISUALIZER_IR_USERNAME="${IR_VISUALIZER_IR_USERNAME:=username}"
export IR_VISUALIZER_IR_PASSWORD="${IR_VISUALIZER_IR_PASSWORD:=password}"
########################################################################################################################


########################################################################################################################
####### minecraft ######################################################################################################
########################################################################################################################
export MINECRAFT_RCON_PASSWORD="${MINECRAFT_RCON_PASSWORD:=password}"
export MINECRAFT_S3_BACKUP_ACCESS_KEY="${MINECRAFT_S3_BACKUP_ACCESS_KEY:=access_key}"
export MINECRAFT_S3_BACKUP_SECRET_KEY="${MINECRAFT_S3_BACKUP_SECRET_KEY:=secret_key}"
export MINECRAFT_S3_BACKUP_ENDPOINT="${MINECRAFT_S3_BACKUP_ENDPOINT:=http://example/deadbeef}" # your S3 endpoint
export MINECRAFT_S3_BACKUP_BUCKET="${MINECRAFT_S3_BACKUP_BUCKET:=bucketname}" # S3 bucket to upload backups to
########################################################################################################################
