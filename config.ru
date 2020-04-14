require 'sinatra/base'
require 'sinatra/extension'
require 'sinatra/json'
require 'sinatra/cookies'
require 'sinatra/streaming'
require 'fileutils'

require 'byebug' if Sinatra::Base.development?

require './web/server'

map('/node_modules') { run Rack::Directory.new('node_modules') }
map('/api') { run Server::Api }
map('/') { run Server::Client }
