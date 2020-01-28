module Blueprint
  class Relationship < ::Spaces::Model

    def overrides_for(struct = OpenStruct.new)
      h = struct.to_h
      h.keys.inject({}) do |m, k|
        m[k] =
          begin
            send(h[k])
          rescue TypeError, NoMethodError
            h[k]
          end
        m
      end
    end

    def host
      "#{descriptor.identifier}.spaces.internal"
    end

    def name
      descriptor.identifier
    end

    def username
      "#{descriptor.identifier}_user"
    end

    def password
      @password ||= SecureRandom.hex(10)
    end

  end
end
