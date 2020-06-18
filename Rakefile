require 'sinatra/base'
require 'sinatra/extension'
require 'sinatra/json'
require 'sinatra/cookies'
require 'sinatra/streaming'
require 'fileutils'
require 'logger'

require 'byebug' if Sinatra::Base.development?

require './web/app'

# run App::Api
# map('/node_modules') { run Rack::Directory.new('./node_modules') }
# map('/api') { run App::Api }
# map('/') { run App::Client }

Dir.glob( './tasks/**/*.rb' ).each { |file| load file }

# task default: [:release]
