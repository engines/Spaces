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

  end
end
