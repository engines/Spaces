module Packaging
  class Accessor < ::Spaces::Thing

    relation_accessor :state

    delegate(
      [:identifier, :struct] => :state
    )

    def initialize(state)
      self.state = state
    end

  end
end
