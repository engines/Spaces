require 'forwardable'
require 'yaml'
require 'json'
require 'duplicate'
require 'pathname'
require 'i18n'
require 'engines-logger'

module Requires

  include Engines::Logger

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
    ENV['DEBUG'] && puts("require -> #{path}")
    require path
  end
end


include Requires

require 'spaces/recovery'

req 'spaces/spaces/requires'
req 'spaces/engines/requires'

require_all 'spaces/providers'

req 'spaces/universe'
