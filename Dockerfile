FROM resin/rpi-raspbian

MAINTAINER the.soulman.is@gmail.com

# Install wget, Download MongoDB 3.0.9 ARM build, untar
RUN apt-get update && \
    apt-get -y install wget && \
    apt-get -y install binutils && \
    apt-get install libssl1.0.0 libssl-dev -y

RUN wget -O /tmp/core_mongodb.tar.gz http://andyfelong.com/downloads/core_mongodb.tar.gz && \
    wget -O /tmp/tools_mongodb.tar.gz http://andyfelong.com/downloads/tools_mongodb.tar.gz

RUN tar -zxf /tmp/core_mongodb.tar.gz -C /usr/bin \
    && tar -zxf /tmp/tools_mongodb.tar.gz -C /usr/bin \
    && adduser --ingroup nogroup --shell /etc/false --disabled-password --gecos "" --no-create-home mongodb \
    && chown root:root /usr/bin/mongo* \
    && chmod 755 /usr/bin/mongo* \
    && strip /usr/bin/mongo* \
    && mkdir -p /var/log/mongodb \
    && chown mongodb:nogroup /var/log/mongodb \
    && mkdir -p /var/lib/mongodb \
    && chown mongodb:root /var/lib/mongodb \
    && chmod 775 /var/lib/mongodb \
    && mkdir -p /data/db \
    && rm -Rf /tmp/*

# This copies contents of dir config to /root
COPY config /root
RUN mv /root/mongodb.conf /etc/mongodb.conf \
    && mv /root/mongodb.service /lib/systemd/system/mongodb.service \
    && chmod 755 /root/run.sh

VOLUME ["/data"]

EXPOSE 27017

CMD ["/root/run.sh"]
