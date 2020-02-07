require_relative '../spaces/model'
require_relative '../image/subject/collaboration'

module Package
  class Package < ::Spaces::Model
    include Image::Subject::Collaboration

    Dir["#{__dir__}/scripts/*"].each { |f| require f }

    class << self
      def script_precedence
        @@package_script_precedence ||= [:installation]
      end
    end

    relation_accessor :context

    def subspace_path
      context.subspace_path
    end

    def image_space_path
       context.image_space_path
    end

    def initialize(struct:, context:)
      self.struct = struct
      self.context = context
    end

  end
end
