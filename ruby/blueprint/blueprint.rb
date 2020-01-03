require 'duplicate'

require_relative '../spaces/model'
require_relative '../container/tensor'

module Blueprint
  class Blueprint < ::Spaces::Model
    # A plan for making software executable and usable, potentially many times over

    relation_accessor :container_tensor

    def container_tensor
      @container_tensor ||= Container::Tensor.new(duplicate(struct))
    end

  end
end
