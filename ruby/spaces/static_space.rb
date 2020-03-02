require_relative 'space'

module Spaces
  class StaticSpace < Space

    def subspace_path_for(descriptor)
      "#{path}/#{descriptor.static_identifier}"
    end

  end
end
