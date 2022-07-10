module Arenas
  module Blueprinting

    def blueprinted = deep_blueprints(:select)
    def unblueprinted = deep_blueprints(:reject)

    def deep_blueprints(method)
      deep_connect_bindings.send(method) do |b|
        blueprints.exist?(b.target_identifier)
      end
    end

  end
end
