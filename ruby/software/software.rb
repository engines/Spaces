require_relative '../spaces/model'
require_relative '../docker/file/collaboration'

class Software < ::Spaces::Model
  include Docker::File::Collaboration

  Dir["#{__dir__}/steps/*"].each { |f| require f }
  Dir["#{__dir__}/scripts/*"].each { |f| require f }

  class << self
    def step_precedence
      @@software_step_precedence ||= { late: [:packages] }
    end

    def script_precedence
      @@software_script_precedence ||= [:installation]
    end
  end

end
