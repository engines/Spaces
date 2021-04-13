require 'sinatra'
require 'byebug'
require 'mini_magick'
require 'letter_avatar'
require 'fastimage'
require 'pathname'

require './api/spaces'
require './api/arenas'
require './api/blueprints'
require './api/metrics'
require './api/packing'
require './api/provisioning'
require './api/publications'
require './api/resolutions'
require './api/system'

set show_exceptions: false

after do
  content_type 'application/json' unless content_type
end

error do |e|
  content_type :text
  e.full_message.tap { |message| logger.error(message) }
end

def query
  request.env['rack.request.query_hash'].transform_keys!(&:to_sym)
end

def resolution_identifier
  params[:resolution_identifier].sub('::', '/')
end
