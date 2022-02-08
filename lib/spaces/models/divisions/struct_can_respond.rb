module Divisions
  module StructCanRespond

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
