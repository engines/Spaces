def callback =
  ->(raw) {
    message = JSON.parse(raw, symbolize_names: true)
    print "#{message[:output]}" if message[:output]
    print "\033[0;33m#{message[:error]}\033[0m" if message[:error]
    print "\033[0;31m#{message[:exception]}\033[0m" if message[:exception]
  }


require 'byebug'

require './x/common/controllers'
require './x/common/domains'
require './x/docker_local/providers'
require './x/docker_local/base_image'
# require './x/docker_local/infrastructure'
require './x/docker_local/services'
require './x/docker_local/applications'
