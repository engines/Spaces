#TODO: Deprecated! ... need to move to blueprint Scaling Division
module Divisions
  class Deployment < ::Divisions::Division

    class << self
      def prototype(emission:, label:)
        class_for(:divisions, emission.qualifier_for(:orchestration), qualifier).new(emission: emission, label: label)
      rescue NameError
        new(emission: emission, label: label)
      end
    end

  end
end
