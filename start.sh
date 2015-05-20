createuser -h "$POSTGRES_PORT_5432_TCP_ADDR" -p "$POSTGRES_PORT_5432_TCP_PORT" -U postgres nfldb
createdb -h "$POSTGRES_PORT_5432_TCP_ADDR" -p "$POSTGRES_PORT_5432_TCP_PORT" -U postgres -O nfldb nfldb
psql -h "$POSTGRES_PORT_5432_TCP_ADDR" -p "$POSTGRES_PORT_5432_TCP_PORT" -U nfldb nfldb < /nfldb.sql

# change config to new psql connection
sed -i "s/host\s=\s.*/host = $POSTGRES_PORT_5432_TCP_ADDR/g" /root/.config/nfldb/config.ini
sed -i "s/port\s=\s.*/port = $POSTGRES_PORT_5432_TCP_PORT/g" /root/.config/nfldb/config.ini

nfldb-update --interval 120
