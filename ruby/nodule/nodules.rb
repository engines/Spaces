require_relative '../spaces/model'
require_relative '../docker/file/collaboration'

module Nodule
  class Nodules < ::Spaces::Model
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
      @all ||= struct.map { |s| universe.nodules.by(s) }
    end

    def scripts
      all.map { |a| a.scripts }
    end

    def path
      'modules'
    end

  end
end
