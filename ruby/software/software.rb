require_relative '../spaces/model'
require_relative '../image/subject/collaboration'
require_relative 'package'

class Software < ::Spaces::Model
  include Image::Subject::Collaboration

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
