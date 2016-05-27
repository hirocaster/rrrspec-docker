FROM rrrspec/rrrspec-base

# MySQL
RUN DEBIAN_FRONTEND=noninteractive apt-get install --yes \
  mysql-server \
  mysql-client \
  libmysqlclient-dev

EXPOSE 3306

Add ./my.cnf /root/.my.cnf

ENV RRRSPEC_CONFIG_FILES /opt/lib/rrrspec-server-config.rb
WORKDIR /opt/rrrspec/rrrspec
RUN bundle install

ENTRYPOINT [ \
  "prehook", \
    "ruby --version", \
    "mysqld --version", \
    "--", \
  "switch", \
    "shell=/bin/bash", \
    "--", \
  "codep", \
    "mysqld_safe", \
    "rrrspec-server worker --no-daemonize" \
]
