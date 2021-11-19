module Arenas
  module Blueprinting

    def blueprinted; deep_blueprints(:select) ;end
    def unblueprinted; deep_blueprints(:reject) ;end

    def deep_blueprints(method)
      deep_connect_bindings.send(method) do |b| # NOW WHAT?
        blueprints.exist?(b.target_identifier)
      end
    end

  end
end
