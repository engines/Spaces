require_relative '../spaces/model'
require_relative '../images/collaboration'

module Nodules
  class Nodule < ::Spaces::Model
    include Images::Collaboration

    relation_accessor :context

    class << self
      def script_precedence
        @@nodule_script_precedence ||= [:installation]
      end
    end

    def subspace_path
      context.subspace_path
    end

    def image_space_path
      "#{context.image_space_path}/#{type}"
    end

    def identifier
      name
    end

    def initialize(struct:, context:)
      self.struct = struct
      self.context = context
    end

  end
end
