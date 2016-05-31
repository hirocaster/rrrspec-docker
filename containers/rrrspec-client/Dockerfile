FROM rrrspec/rrrspec-base

RUN git clone https://github.com/hirocaster/rspec-example.git /opt/project

WORKDIR /opt/project

Add .rrrspec ./

Add ./run.sh /tmp/run.sh

CMD /tmp/run.sh
