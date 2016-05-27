FROM rrrspec/rrrspec-base

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
  "prehook", \
    "ruby --version", \
    "--", \
  "switch", \
    "shell=/bin/bash", \
    "--", \
  "codep", \
    "/tmp/run-server.sh", \
    "/tmp/run-web.sh" \
]
