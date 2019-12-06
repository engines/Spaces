require 'sinatra/base'
require 'sinatra/extension'
require 'sinatra/json'
require 'sinatra/cookies'
require 'sinatra/streaming'
require 'byebug' if Sinatra::Base.development?
require 'fileutils'

require './server'
require './config'
Config.mount( self )
Config.warmup( self )
