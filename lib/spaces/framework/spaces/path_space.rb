require_relative 'space'
require_relative 'paths'
require_relative 'reading'
require_relative 'saving'
require_relative 'deleting'
require_relative 'topology'

module Spaces
  class PathSpace < Space
    include Paths
    include Reading
    include Saving
    include Deleting
    include Topology

    def all
      identifiers.map { |i| by(i) }
    end

    def identifiers(*_)
      path.glob('*').map { |p| p.basename.to_s }
    end

    def exist?(identifiable)
      identifiable && path_for(identifiable).exist?
    end

    def ensure_space; path.mkpath ;end

  end
end
