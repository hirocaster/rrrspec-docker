FROM ruby:2.2

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

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
  apt-get install -y nodejs rsync ssh && \
  update-alternatives --install /usr/bin/node node /usr/bin/nodejs 10 && \
  apt-get clean
RUN gem install --no-ri --no-rdoc rake foreman

ADD lib /opt/lib/

RUN git clone https://github.com/cookpad/rrrspec.git /opt/rrrspec
RUN cd /opt/rrrspec/rrrspec-server ; bundle install ; rake build ; gem install pkg/*.gem

CMD /bin/bash
