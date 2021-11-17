module Divisions
  class Deployment < ::Divisions::Division

    class << self
      def prototype(emission:, label:)
        class_for(:divisions, emission.provisioning_qualifier, qualifier).new(emission: emission, label: label)
      end
    end

  end
end
