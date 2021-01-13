require 'sinatra'
require 'byebug'
require 'mini_magick'
require 'letter_avatar'
require 'fastimage'
require 'pathname'


require './api/universe'
require './api/arenas'
require './api/metrics'
require './api/packing'
require './api/provisioning'
require './api/resolutions'
require './api/system'
require './api/import'
require './api/crud'

set show_exceptions: false

after do
  content_type 'application/json' unless content_type
end

error do |e|
  content_type :text
  e.full_message.tap { |message| logger.error(message) }
end
