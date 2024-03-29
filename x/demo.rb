def callback =
  ->(raw) {
    message = JSON.parse(raw, symbolize_names: true)
    print "#{message[:output]}" if message[:output]
    print "\033[0;33m#{message[:error]}\033[0m" if message[:error]
    print "\033[0;31m#{message[:exception]}\033[0m" if message[:exception]
  }


require 'byebug'

require './x/common/controllers'

# require './x/demo/packer-terraform-aws/nuke'
# require './x/demo/packer-terraform-aws/image'
# require './x/demo/packer-terraform-aws/mxr'
# require './x/demo/packer-terraform-aws/registry'
# require './x/demo/packer-terraform-aws/applications'

require './x/demo/docker-docker_compose/nuke'
require './x/demo/docker-docker_compose/init'
require './x/demo/docker-docker_compose/base'
require './x/demo/docker-docker_compose/infrastructure'
# require './x/demo/docker-docker_compose/services'
# require './x/demo/docker-docker_compose/applications'
