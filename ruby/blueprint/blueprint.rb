require 'duplicate'

require_relative '../spaces/model'
require_relative '../spaces/descriptor'
require_relative 'tensor'

module Blueprint
  class Blueprint < ::Spaces::Model
    # A plan for making software executable and usable, potentially many times over

    relation_accessor :tensor

    def tensor
      @tensor ||= tensor_class.new(duplicate(struct))
    end

    def dependency_descriptors
      struct.dependencies&.map { |d|
        descriptor_class.new(d.descriptor)
      } || []
    end

    def file_path
      "#{name}/#{self.class.unqualified_identifier}"
    end

    def tensor_class
      Tensor
    end
  end
end
