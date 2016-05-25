FROM ruby:2.2

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
  apt-get install -y nodejs rsync ssh && \
  update-alternatives --install /usr/bin/node node /usr/bin/nodejs 10 && \
  apt-get clean
RUN gem install --no-ri --no-rdoc rake foreman

ADD lib /opt/lib/

RUN git clone https://github.com/cookpad/rrrspec.git /opt/rrrspec
RUN cd /opt/rrrspec/rrrspec ; bundle install
RUN cd /opt/rrrspec/rrrspec-client ; rake build ; gem install pkg/*.gem
RUN cd /opt/rrrspec/rrrspec-server ; rake build ; gem install pkg/*.gem

CMD /bin/bash
