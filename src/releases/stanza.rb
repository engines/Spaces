require_relative '../spaces/model'

module Releases
  class Stanza < ::Spaces::Model

    relation_accessor :context

    delegate([:identifier, :collaboration] => :context)

    def initialize(context)
      self.context = context
    end

  end
end
