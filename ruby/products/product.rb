require_relative '../spaces/model'

module Products
  class Product < ::Spaces::Model

    class << self
      def prototype(tensor)
        new(tensor)
      end
    end

    relation_accessor :tensor

    def descriptor
     tensor.descriptor
    end

    def initialize(tensor)
      self.tensor = tensor
    end

  end
end
