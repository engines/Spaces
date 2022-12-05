def callback =
  ->(raw) {
    message = JSON.parse(raw, symbolize_names: true)
    print "#{message[:output]}" if message[:output]
    print "\033[0;33m#{message[:error]}\033[0m" if message[:error]
    print "\033[0;31m#{message[:exception]}\033[0m" if message[:exception]
  }


require 'byebug'

require './x/common/controllers'

require './x/demo/terraform-aws/nuke'
require './x/demo/terraform-aws/image'
require './x/demo/terraform-aws/mxr'
require './x/demo/terraform-aws/registry'
require './x/demo/terraform-aws/applications'
