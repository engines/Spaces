# Monkey patch docker-compose gem
#
# Yield IO from the :up command to a block.
require 'docker/compose'
require 'gems/docker-compose/session'
