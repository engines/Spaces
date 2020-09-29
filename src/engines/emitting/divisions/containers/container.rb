module Divisions
  class Container < ::Emissions::Subdivision

    class << self
      def constant_for(struct:)
        Module.const_get("/providers/#{struct.type}/container".camelize)
      end
    end

    delegate(identifier: :emission)

  end
end
