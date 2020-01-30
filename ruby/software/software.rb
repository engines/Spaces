require_relative '../spaces/model'
require_relative '../docker/file/collaboration'
require_relative 'package'

class Software < ::Spaces::Model
  include Docker::File::Collaboration

  Dir["#{__dir__}/scripts/*"].each { |f| require f }

  relation_accessor :packages

  class << self
    def script_precedence
      @@software_script_precedence ||= [:installation]
    end
  end

  def packages
    @packages ||= struct.packages.map { |p| package_class.new(p) }
  end

  def package_class
    Package
  end

  def identifier
    title
  end

end
