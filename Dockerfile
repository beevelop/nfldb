FROM python:2.7

ADD config.ini /root/.config/nfldb/config.ini
ADD start.sh /start.sh

RUN apt-get -q update && apt-get -qy install unzip postgresql-client && \
    wget http://burntsushi.net/stuff/nfldb/nfldb.sql.zip && \
    unzip nfldb.sql.zip && \
    pip2 install nfldb && \
    chmod 700 /start.sh

ENTRYPOINT /start.sh
