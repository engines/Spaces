module Providers
  class Interface < ::Spaces::Model
    include ::Spaces::Streaming

    relation_accessor :adapter
    relation_accessor :space

    delegate(
      [:artifacts, :emission] => :adapter,
      [:arenas, :path_for] => :space,
      path: :arenas
    )

    alias_method :pack, :emission
    alias_method :provisions, :emission

    def save_artifacts
      artifacts.each do |a|
        artifact_path.write(a.value)
      end
    end

    def initialize(adapter, space = nil)
      self.adapter = adapter
      self.space = space
    end

  end
end
