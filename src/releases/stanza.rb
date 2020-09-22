require_relative '../spaces/model'

module Releases
  class Stanza < ::Spaces::Model

    relation_accessor :context

    delegate([:identifier, :release] => :context)

    def declaratives
      "#{klass} - nothing here yet"
    end

    def initialize(context)
      self.context = context
    end

  end
end
