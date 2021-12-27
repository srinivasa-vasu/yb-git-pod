FROM gitpod/workspace-full

ARG YB_VERSION=2.11.1.0
ARG ROLE=gitpod

USER root

RUN apt-get update && \
  apt-get -y install netcat --no-install-recommends

RUN curl -sSLo ./yugabyte.tar.gz https://downloads.yugabyte.com/yugabyte-${YB_VERSION}-linux.tar.gz \
  && mkdir yugabyte \
  && tar -xvf yugabyte.tar.gz -C yugabyte --strip-components=1 \
  && mv ./yugabyte /usr/local/ \
  && ln -s /usr/local/yugabyte/bin/yugabyted /usr/local/bin/yugabyted \
  && ln -s /usr/local/yugabyte/bin/ysqlsh /usr/local/bin/ysqlsh \
  && ln -s /usr/local/yugabyte/bin/ycqlsh /usr/local/bin/ycqlsh \
  && chmod +x /usr/local/bin/yugabyted \
  && chmod +x /usr/local/bin/ysqlsh \
  && chmod +x /usr/local/bin/ycqlsh \
  && rm ./yugabyte.tar.gz

RUN mkdir -p /var/ybdp \
  && chown -R $ROLE:$ROLE /var/ybdp \
  && chown -R $ROLE:$ROLE /usr/local/yugabyte

USER $ROLE

ENV HOST_LB=127.0.0.1
ENV HOST_LB2=127.0.0.2
ENV HOST_LB3=127.0.0.3
ENV STORE=/var/ybdp
ENV YSQL_PORT=5433
ENV YCQL_PORT=9042
ENV WEB_PORT=7000
ENV TSERVER_WEB_PORT=9000
ENV YCQL_API_PORT=12000
ENV YSQL_API_PORT=13000

EXPOSE ${YSQL_PORT} ${YCQL_PORT} ${WEB_PORT} ${TSERVER_WEB_PORT} ${YSQL_API_PORT} ${YCQL_API_PORT}