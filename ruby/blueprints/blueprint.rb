require_relative '../spaces/model'
require_relative '../spaces/descriptor'
require_relative '../tensors/tensor'

module Blueprints
  class Blueprint < ::Spaces::Model

    relation_accessor :tensor

    def tensor
      @tensor ||= tensor_class.new(self)
    end

    def text_file_names
      universe.blueprints.text_file_names_for(descriptor)
    end

    def service_descriptors
      struct.dependencies&.map { |d| descriptor_class.new(d.descriptor) } || []
    end

    def tensor_class
      ::Tensors::Tensor
    end
  end
end
