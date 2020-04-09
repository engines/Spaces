require_relative 'product'

module Installations
  class Subdivision < Product

    relation_accessor :context

    delegate([:installation, :path, :context_identifier] => :context)

    def initialize(struct:, context:)
      self.struct = struct
      self.context = context
    end

  end
end
