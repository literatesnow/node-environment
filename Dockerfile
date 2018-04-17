FROM node:9

ARG USER_UID=2000
ARG USER_GID=2000

RUN echo "Install apt" \
  && echo "Modify user" \
  && groupmod -g "$USER_GID" node \
  && usermod -u "$USER_UID" -s /bin/bash node \
  && echo "Permissions" \
  && chown -R node:node /home/node/ \
  && echo "Cleaning up" \
  && apt-get clean -y \
  && apt-get --purge -y autoremove -y \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && echo "Done"

USER node

ENV CHOKIDAR_USEPOLLING=1 \
    CHOKIDAR_INTERVAL=1000 \
    PATH=$PATH:/home/node/.yarn/bin

WORKDIR /data/
VOLUME /data

EXPOSE 1234
EXPOSE 11234

ENTRYPOINT ["/bin/bash"]
