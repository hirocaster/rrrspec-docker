FROM rrrspec/rrrspec-base

ENV RRRSPEC_CONFIG_FILES /opt/lib/rrrspec-server-config.rb
WORKDIR /opt/rrrspec/rrrspec
RUN bundle install
CMD bundle exec rrrspec-server worker --no-daemonize
