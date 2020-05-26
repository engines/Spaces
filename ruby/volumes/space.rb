require_relative '../bridges/space'
require_relative '../docker/volumes/space'

module Volumes
  class Space < ::Bridges::Space

    def bridge; @bridge ||= Docker::Volumes::Space.new ;end

  end
end
