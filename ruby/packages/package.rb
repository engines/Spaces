require_relative '../spaces/model'
require_relative '../images/collaboration'

module Packages
  class Package < ::Spaces::Model
    include Images::Collaboration

    Dir["#{__dir__}/scripts/*"].each { |f| require f }

    class << self
      def script_precedence
        @@package_script_precedence ||= [:preparation, :installation]
      end
    end

    relation_accessor :context

    def subspace_path
      context.subspace_path
    end

    def build_script_path
       context.build_script_path
    end

    def initialize(struct:, context:)
      self.struct = struct
      self.context = context
    end

  end
end
