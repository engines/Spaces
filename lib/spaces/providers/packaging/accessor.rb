module Packaging
  class Accessor < ::Spaces::Thing

    class << self
      def class_for(name) = super(:packaging, name.to_s.camelize)
    end

    relation_accessor :state

    delegate(
      [:identifier, :struct] => :state
    )

    def initialize(state)
      self.state = state
    end

  end
end
