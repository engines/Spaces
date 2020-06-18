require 'sinatra/base'
require 'sinatra/extension'
require 'sinatra/json'
require 'sinatra/cookies'
require 'sinatra/streaming'
require 'fileutils'
require 'logger'

require 'byebug' if Sinatra::Base.development?

require './web/app'

Dir.glob( './tasks/**/*.rb' ).each { |file| load file }
