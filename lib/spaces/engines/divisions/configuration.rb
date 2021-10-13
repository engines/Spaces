module Divisions
  class Configuration < ::Divisions::Division

    alias_method :original_embedded_with, :embedded_with

    def embedded_with(other); original_embedded_with(other) ;end

    def inflated; self ;end
    def deflated; self ;end

    def method_missing(m, *args, &block)
      if struct.keys.include?(m.to_s.sub('=', '').to_sym)
        struct.send(m, *args, &block)
      else
        super
      end
    end

    def respond_to_missing?(m, *)
      struct.keys.include?(m) || super
    end

  end
end
