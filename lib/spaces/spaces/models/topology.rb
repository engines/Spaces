module Spaces
  module Topology

    def graph(identifier, **args)
      by(identifier).graphed(**(args.without(:identifier, :space)))
    end

  end
end
