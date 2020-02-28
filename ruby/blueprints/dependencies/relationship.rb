module Blueprints
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
      "#{name}.#{universe.host}"
    end

    def name
      descriptor.identifier
    end

    def username
      "#{name}_user"
    end

    def password
      @password ||= SecureRandom.hex(10)
    end

  end
end
