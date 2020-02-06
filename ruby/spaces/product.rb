require_relative 'model'

module Spaces
  class Product < Model

    relation_accessor :tensor

    def identifier
      tensor.title
    end

    def descriptor
     tensor.descriptor
    end

    def initialize(tensor)
      self.tensor = tensor
    end

  end
end
