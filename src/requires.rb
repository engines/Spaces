require 'forwardable'
require 'yaml'
require 'json'
require 'duplicate'
require 'pathname'
require 'i18n'

require 'file'
require 'engines-logger'

# FIXME: This doesn't do what I think it should.
#
# The idea is that require_multiple be private but it isn't and I don't know why.

module Requires

  def require_all(dir_name, file_name = '*')
    require_multiple(dir_name, file_name, recurse: true)
  end

  def require_level(dir_name, file_name = '*')
    require_multiple(dir_name, file_name, recurse: false)
  end

  private

  def require_multiple(dir_name, file_name = '*', recurse:)
    pattern = (recurse) ? "**/#{file_name}.rb" : "#{file_name}.rb"
    $LOAD_PATH.map do |p|
      Pathname.new(p).join(dir_name).glob(pattern, &method(:req))
    end
  end

  def req(path)
    defined?(DEBUG) && DEBUG && STDERR.puts(path)
    require path
  end
end

include Requires


require_level 'spaces'
require_level 'engines'
require_all   'providers'
