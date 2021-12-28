FROM gitpod/workspace-full

ARG YB_VERSION=2.8.0.0
ARG ROLE=gitpod

USER $ROLE
RUN curl -sSLo ./yugabyte.tar.gz https://downloads.yugabyte.com/yugabyte-${YB_VERSION}-linux.tar.gz \
  && mkdir yugabyte \
  && tar -xvf yugabyte.tar.gz -C yugabyte --strip-components=1 \
  && chmod +x ./yugabyte/bin/* \
  && rm ./yugabyte.tar.gz

USER root  
RUN  mv ./yugabyte /usr/local/ \
  && mkdir -p /var/ybdp \
  && chown -R $ROLE:$ROLE /var/ybdp
  
USER $ROLE
RUN ["/usr/local/yugabyte/bin/post_install.sh"]

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

RUN echo "\n# yugabytedb executable path" >> ~/.bashrc
RUN echo "export PATH=\$PATH:/usr/local/yugabyte/bin/" >> ~/.bashrc

EXPOSE ${YSQL_PORT} ${YCQL_PORT} ${WEB_PORT} ${TSERVER_WEB_PORT} ${YSQL_API_PORT} ${YCQL_API_PORT}
