require_relative '../spaces/model'
require_relative '../images/collaboration'

module FilePermissions
  class FilePermission < ::Spaces::Model
    include Images::Collaboration

    Dir["#{__dir__}/scripts/*"].each { |f| require f }
    Dir["#{__dir__}/steps/*"].each { |f| require f }

    class << self
      def script_lot
        @@file_permission_script_lot ||= [:preparation, :installation]
      end

      def step_precedence
        @@file_permission_step_precedence ||= { late: [:run_scripts] }
      end
    end
    
    relation_accessor :context

    def subspace_path
      context.subspace_path
    end

    def initialize(struct:, context:)
      self.struct = struct
      self.context = context
    end

  end
end
