module Arenas
  module Connecting

    def connect_with(other_identifier)
      empty.tap do |m|
        m.struct = struct
        m.struct.tap do |s|
          s.connections = [connection_for(other_identifier), s.connections].flatten.uniq
        end
      end
    end

    def connection_for(other_identifier)
      OpenStruct.new(identifier: other_identifier)
    end

    # def deep_connect_identifiers_under
    #   deep_connect_bindings_under.map(&:identifier)
    # end
    
    def deep_connect_bindings_under
      deep_arenas_under.map(&:deep_connect_bindings).flatten.compact
    end

    def deep_connect_bindings
      [
        deep_arenas_under.map(&:deep_connect_bindings),
        super
      ].flatten.uniq(&:uniqueness)
    end

    def deep_arenas
      [deep_arenas_under, self].flatten.uniq(&:uniqueness)
    end

    def deep_arenas_under
      connected_arenas.map(&:deep_arenas).flatten.compact
    end

    def connected_arenas
      connections.all.map(&:arena)
    end

  end
end
