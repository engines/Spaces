require_relative '../engines/model'
require_relative 'license'
require_relative 'framework'

module Software
  class Software < Engines::Model
    # AKA Software Product
    # A major version of software which can be made executable and usable in various ways through any number of blueprints

    relation_accessor :license,
      :framework

    attr_accessor :title,
      :label,
      :memory_required,
      :memory_recommended

  end
end
