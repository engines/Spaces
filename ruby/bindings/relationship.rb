module Bindings
  class Relationship < ::Spaces::Model

    def overrides_for(struct = OpenStruct.new)
      h = struct.to_h
      h.keys.inject({}) do |m, k|
        m[k] =
          begin
            send(*h[k].split(/[()]+/))
          rescue TypeError, ArgumentError, NoMethodError
            h[k]
          end
        m
      end
    end

    def host
      "#{descriptor.static_identifier}.#{universe.host}"
    end

    def name
      descriptor.identifier
    end

    def username
      "#{name}_user"
    end

    def random(length)
      SecureRandom.hex(length.to_i)
    end

  end
end
