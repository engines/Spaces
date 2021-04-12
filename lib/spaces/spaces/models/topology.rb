module Spaces
  module Topology

    def graph(identifier, **args)
      if exist?(identifier)
        by(identifier).graphed(**args)
      end
    end

  end
end
