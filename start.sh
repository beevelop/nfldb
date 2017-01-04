PGPASSWORD="$POSTGRES_ENV_POSTGRES_PASSWORD" psql -h "$POSTGRES_PORT_5432_TCP_ADDR" -p "$POSTGRES_PORT_5432_TCP_PORT" -U "$POSTGRES_ENV_POSTGRES_USER" $POSTGRES_ENV_POSTGRES_DB < /nfldb.sql

# change config to new psql connection
sed -i "s/host\s=\s.*/host = $POSTGRES_PORT_5432_TCP_ADDR/g" /root/.config/nfldb/config.ini
sed -i "s/port\s=\s.*/port = $POSTGRES_PORT_5432_TCP_PORT/g" /root/.config/nfldb/config.ini
sed -i "s/password\s.*/password = $POSTGRES_ENV_POSTGRES_PASSWORD/g" /root/.config/nfldb/config.ini
sed -i "s/user\s.*/user = $POSTGRES_ENV_POSTGRES_USER/g" /root/.config/nfldb/config.ini
sed -i "s/database\s.*/database = $POSTGRES_ENV_POSTGRES_DB/g" /root/.config/nfldb/config.ini

PGPASSWORD="$POSTGRES_ENV_POSTGRES_PASSWORD" psql -h "$POSTGRES_PORT_5432_TCP_ADDR" -p "$POSTGRES_PORT_5432_TCP_PORT" -U "$POSTGRES_ENV_POSTGRES_USER" $POSTGRES_ENV_POSTGRES_DB -c "INSERT into team values('JAX','Jacksonville', 'Jaguars');"
nfldb-update
PGPASSWORD="$POSTGRES_ENV_POSTGRES_PASSWORD" psql -h "$POSTGRES_PORT_5432_TCP_ADDR" -p "$POSTGRES_PORT_5432_TCP_PORT" -U "$POSTGRES_ENV_POSTGRES_USER" $POSTGRES_ENV_POSTGRES_DB -c "UPDATE play SET pos_team = 'JAC' WHERE pos_team = 'JAX';"
PGPASSWORD="$POSTGRES_ENV_POSTGRES_PASSWORD" psql -h "$POSTGRES_PORT_5432_TCP_ADDR" -p "$POSTGRES_PORT_5432_TCP_PORT" -U "$POSTGRES_ENV_POSTGRES_USER" $POSTGRES_ENV_POSTGRES_DB -c "DELETE FROM team WHERE team_id = 'JAX';"
nfldb-update --interval 120
