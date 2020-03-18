require_relative '../spaces/model'
require_relative '../images/collaboration'
require_relative '../docker/files/collaboration'

module Nodules
  class Nodule < ::Spaces::Model
    include Images::Collaboration
    include Docker::Files::Collaboration

    relation_accessor :context

    class << self

      def qualifier
        name.split('::').last.downcase
      end

      def script_lot
        @@nodule_script_lot ||= [:installation]
      end

      def step_precedence
        @@nodule_step_precedence ||= {}
      end
    end

    def subspace_path
      context.subspace_path
    end

    def build_script_path
      "#{context.build_script_path}/#{type}"
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
