require_relative 'product'

module Collaborators
  class Subdivision < Product

    relation_accessor :context

    delegate([:installation, :product_path, :context_identifier] => :context)

    def initialize(struct:, context:)
      self.struct = struct
      self.context = context
    end

  end
end
