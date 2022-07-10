def callback
  ->(raw) {
    message = JSON.parse(raw, symbolize_names: true)
    print "#{message[:output]}" if message[:output]
    print "\033[0;33m#{message[:error]}\033[0m" if message[:error]
    print "\033[0;31m#{message[:exception]}\033[0m" if message[:exception]
  }
end

require 'byebug'

require './x/controllers'
require './x/demo/nuke'
require './x/demo/init'
require './x/demo/base'
# require './x/demo/infrastructure'
# require './x/demo/services'
# require './x/demo/applications'
