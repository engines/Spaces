require_relative '../spaces/model'
require_relative '../docker/file/collaboration'
require_relative 'package'

class Software < ::Spaces::Model
  include Docker::File::Collaboration

  Dir["#{__dir__}/steps/*"].each { |f| require f }

  class << self
    def step_precedence
      @@software_step_precedence ||= {
        late: [:run_scripts]
      }
    end
  end

  relation_accessor :packages

  def packages
    @packages ||= struct.packages.map { |s| package_class.new(struct: s, context: self) }
  end

  def scripts
    packages.map { |s| s.scripts }
  end

  def package_class
    Package
  end

  def identifier
    title
  end

end
