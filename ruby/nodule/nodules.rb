require_relative '../spaces/product'
require_relative '../image/subject/collaboration'
require_relative '../docker/file/collaboration'

module Nodule
  class Nodules < ::Spaces::Product
    include Docker::File::Collaboration
    include Image::Subject::Collaboration

    Dir["#{__dir__}/scripts/*"].each { |f| require f }
    Dir["#{__dir__}/steps/*"].each { |f| require f }

    class << self
      def script_precedence
        @@nodules_script_precedence ||= [:os_packages]
      end

      def step_precedence
        @@nodules_step_precedence ||= { late: [:run_scripts] }
      end
    end

    def all
      @all ||= tensor.struct.modules.map { |s| universe.nodules.by(struct: s, context: self) }
    end

    def scripts
      [
        super,
        all.map { |s| s.scripts }
      ].flatten
    end

    def image_space_path
       'modules'
    end

  end
end
