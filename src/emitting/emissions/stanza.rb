module Emissions
  class Stanza < ::Spaces::Model

    relation_accessor :context

    delegate([:identifier, :emission] => :context)

    def declaratives
      "#{klass} - nothing here yet"
    end

    def initialize(context)
      self.context = context
    end

  end
end
