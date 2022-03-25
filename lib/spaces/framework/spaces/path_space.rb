require_relative 'space'
require_relative 'paths'
require_relative 'reading'
require_relative 'saving'
require_relative 'deleting'
require_relative 'topology'

module Spaces
  class PathSpace < Space
    include ::Spaces::Paths
    include ::Spaces::Reading
    include ::Spaces::Saving
    include ::Spaces::Deleting
    include ::Spaces::Topology

    def ensure_space
      path.mkpath
    end

    def all
      identifiers.map { |i| by(i) }
    end

    def identifiers(*_)
      path.glob('*').map { |p| p.basename.to_s }
    end

    def exist?(identifiable)
      identifiable && path_for(identifiable).exist?
    end

  end
end
