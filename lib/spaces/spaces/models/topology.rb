module Spaces
  module Topology

    def graph(identifier, **keyword_args)
      if exist?(identifier)
        by(identifier).graph(**keyword_args)
      end
    end

  end
end
