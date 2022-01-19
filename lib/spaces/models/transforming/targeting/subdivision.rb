require_relative 'targeting'

module Targeting
  class Subdivision < ::Divisions::Subdivision
    include ::Targeting::Targeting

    class << self
      def prototype(type:, struct:, division:)
        new(struct: struct, division: division)
      end
    end

    def identifier; struct.identifier || target_identifier ;end
    def target_identifier; struct.target_identifier || descriptor&.identifier ;end

    def descriptor
      @descriptor ||= descriptor_class.new(
        struct.target || {identifier: struct.target_identifier}
      )
    end

  end
end
