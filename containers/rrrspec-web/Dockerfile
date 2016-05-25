FROM rrrspec/rrrspec-base

ADD config.ru /opt/rrrspec/rrrspec-web/config.ru

WORKDIR /opt/rrrspec/rrrspec-web

RUN bundle install
ENV RRRSPEC_CONFIG_FILES /opt/lib/rrrspec-server-config.rb

EXPOSE 8080

CMD bundle exec unicorn
