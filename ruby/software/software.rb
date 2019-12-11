require_relative '../framework/model'
require_relative 'license'
require_relative 'framework'

module Software
  class Software < ::Framework::Model
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
