FROM rrrspec/rrrspec-base

WORKDIR /opt/rrrspec/rrrspec-server

ENV RRRSPEC_CONFIG_FILES /opt/lib/rrrspec-server-config.rb

RUN bundle install

ADD run.sh /tmp/run.sh

CMD /tmp/run.sh
