FROM rrrspec/rrrspec-base

ENV RRRSPEC_CONFIG_FILES /opt/lib/rrrspec-server-config.rb

RUN git clone https://github.com/hirocaster/rspec-example.git /opt/project

WORKDIR /opt/project

Add ./run.sh /tmp/run.sh

CMD /tmp/run.sh
