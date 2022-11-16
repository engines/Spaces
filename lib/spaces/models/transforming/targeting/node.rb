require_relative 'targeting'
require_relative 'graphing'

module Targeting
  class Node < ::Divisions::Subdivision
    include ::Targeting::Graphing
    include ::Targeting::Targeting

    class << self
      def dynamic_type(type:, struct:, division:) =
        new(struct: struct, division: division)
    end

    def identifier = struct.identifier || target_identifier
    def target_identifier = struct.target_identifier || descriptor&.identifier

    def descriptor
      @descriptor ||= descriptor_class.new(
        struct.target || {identifier: struct.target_identifier}
      )
    end

  end
end
