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

    def all_connect_bindings
      deep_arenas.map(&:deep_connect_bindings).flatten.compact.uniq(&:uniqueness)
    end

    def deep_arenas
      [connected_arenas.map(&:deep_arenas), self].flatten.compact.uniq(&:uniqueness)
    end

    def connected_arenas
      connections.all.map(&:arena)
    end

  end
end
