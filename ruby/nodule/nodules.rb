require_relative '../spaces/model'
require_relative '../docker/file/collaboration'

module Nodule
  class Nodules < ::Spaces::Product
    include Docker::File::Collaboration

    Dir["#{__dir__}/steps/*"].each { |f| require f }

    class << self
      def step_precedence
        @@nodules_step_precedence ||= {
          late: [:run_scripts]
        }
      end
    end

    def all
      @all ||= tensor.modules.map { |s| universe.nodules.by(struct: s, context: self) }
    end

    def scripts
      all.map { |s| s.scripts }
    end

  end
end
