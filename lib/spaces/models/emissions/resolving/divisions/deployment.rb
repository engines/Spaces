#TODO: Deprecated! ... need to move to blueprint Dimensions Division
module Divisions
  class Deployment < ::Divisions::Division

    class << self
      def dynamic_type(emission:, label:)
        class_for(:divisions, emission.qualifier_for(:orchestration), qualifier).new(emission: emission, label: label)
      rescue NameError
        new(emission: emission, label: label)
      end
    end

  end
end
