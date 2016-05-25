FROM rrrspec/rrrspec-base

ENV ENTRYKIT_VERSION 0.4.0

WORKDIR /

# entrykit
RUN DEBIAN_FRONTEND=noninteractive apt-get install --yes \
  wget
RUN wget https://github.com/progrium/entrykit/releases/download/v${ENTRYKIT_VERSION}/entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz --no-check-certificate\
  && tar -xvzf entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
  && rm entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
  && mv entrykit /bin/entrykit \
  && chmod +x /bin/entrykit \
  && entrykit --symlink

# web
ADD config.ru /opt/rrrspec/rrrspec-web/config.ru
WORKDIR /opt/rrrspec/rrrspec-web
RUN bundle install

EXPOSE 8080

# server
WORKDIR /opt/rrrspec/rrrspec-server
RUN bundle install

ENV RRRSPEC_CONFIG_FILES /opt/lib/rrrspec-server-config.rb

ADD run-server.sh /tmp/run-server.sh
ADD run-web.sh /tmp/run-web.sh
# CMD /tmp/run.sh

ENTRYPOINT [ \
  "switch", \
    "shell=/bin/bash", \
    "--", \
  "codep", \
    "/tmp/run-server.sh", \
    "/tmp/run-web.sh" \
]
