require_relative '../spaces/model'
require_relative 'package'

class Software < ::Spaces::Model

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
