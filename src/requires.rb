require 'forwardable'
require 'yaml'
require 'json'
require 'duplicate'
require 'pathname'
require 'i18n'
require 'engines-logger'

module Requires
  def require_all(dir_name, file_name = '*')
    Pathname.glob(Pathname.new("./src/#{dir_name}").join('**', "#{file_name}.rb"), &method(:require))
  end

  def require_level(dir_name, file_name = '*')
    Pathname.glob(Pathname.new("./src/#{dir_name}").join("#{file_name}.rb"), &method(:require))
  end
end

include Requires

require_relative 'file'
require_level 'spaces'
require_level 'engines'
require_all   'providers'
