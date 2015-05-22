# docker-xtbackup
Build Docker container suitable to run [xtbackup](http://k2s.github.io/xtbackup/).

## Simple MySQL Backup

    # your custom parameters (change it)
    HOST_DATA_DIR="~/backup-data"
    MYSQL_DBNAME="mysql"
    MYSQL_HOST="192.168.1.2"
    MYSQL_PORT="3306"
    MYSQL_USER="root"
    MYSQL_PWD=""

    # build xtbackup command line parameters (no need to be changed)
    PARAMS="engine.outputs[]=cli \
    engine.local=mysql storage.mysql.dbname=$MYSQL_DBNAME storage.mysql.basedir='/tmp/xtbackup' \
    storage.mysql.host=$MYSQL_HOST storage.mysql.port=$MYSQL_PORT \
    storage.mysql.user=$MYSQL_USER storage.mysql.password="$MYSQL_PWD" \
    engine.remote=dummy storage.dummy= \
    engine.compare=sqlite compare.sqlite.file='/tmp/xtbackup/compare.db'"

    # execute xtbackup in container
    docker run -it --rm --name xtbackup --net="host" -e XTBACKUP_OPENDIR="/" -v $HOST_DATA_DIR:/tmp/xtbackup bigm/xtbackup xtbackup $PARAMS

