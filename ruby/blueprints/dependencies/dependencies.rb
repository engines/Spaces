require_relative '../../products/product'
require_relative '../../docker/files/collaboration'
require_relative 'dependent'

module Blueprints
  class Dependencies < ::Products::Product
    include Docker::Files::Collaboration

    Dir["#{__dir__}/steps/*"].each { |f| require f }

    def layers_for(group)
      all.map { |a| a.layers_for(group) }
    end

    def all
      @all ||= tensor.struct.dependencies.map { |d| dependent_class.new(d, tensor) } || []
    end

    def dependent_class
      Dependent
    end

  end
end
