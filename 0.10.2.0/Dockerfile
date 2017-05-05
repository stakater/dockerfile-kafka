FROM 	stakater/java8-alpine:1.8.0_121
LABEL	authors="Hazim <hazim_malik@hotmail.com>"

ARG kafka_version=0.10.2.0
ARG scala_version=2.12

ENV KAFKA_VERSION=$kafka_version SCALA_VERSION=$scala_version
ENV KAFKA_HOME /opt/kafka
ENV PATH ${PATH}:${KAFKA_HOME}/bin

ADD download-kafka.sh /tmp/download-kafka.sh
RUN apk add --update unzip wget curl jq coreutils && \
    chmod a+x /tmp/download-kafka.sh && sync && /tmp/download-kafka.sh && \
 		tar xfz /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz -C /opt && \
		rm /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz && \
		ln -s /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION} ${KAFKA_HOME}

# Simulate cmd behavior via environment variable
# So that users are able to provice command line arguments
ENV 	COMMAND "$KAFKA_HOME/bin/kafka-server-start.sh $KAFKA_HOME/config/server.properties"

# Make daemon service dir for kafka and place file
# It will be started and maintained by the base image
RUN 	mkdir -p /etc/service/kafka
ADD 	start.sh /etc/service/kafka/run

# Use base image's entrypoint