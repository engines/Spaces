require_relative '../spaces/model'

module Products
  class Product < ::Spaces::Model

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
