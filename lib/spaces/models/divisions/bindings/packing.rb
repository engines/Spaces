module Divisions
  class Binding < ::Targeting::Binding
    module Packing

      def implies_packable?; !embed? ;end

      def environment_variables
        configuration.to_h.map { |k, v| "--env=#{k}=#{v}" }.join(' ')
      end

    end
  end
end
