module Providers
  class Interface < ::Spaces::Model
    include ::Spaces::Streaming

    relation_accessor :adapter
    relation_accessor :space

    delegate(
      [:emission, :artifact] => :adapter
    )

    alias_method :pack, :emission
    alias_method :provisions, :emission

    def initialize(adapter, space = nil)
      self.adapter = adapter
      self.space = space
    end

  end
end
