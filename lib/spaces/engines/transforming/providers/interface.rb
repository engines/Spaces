module Providers
  class Interface < ::Spaces::Model
    include ::Spaces::Streaming

    relation_accessor :adapter
    relation_accessor :space

    delegate(
      [:provider, :emission] => :adapter,
      [:arenas, :path_for] => :space,
      path: :arenas
    )

    alias_method :pack, :emission
    alias_method :provisions, :emission

    def save_artifact
      artifact_path.write(artifact.value)
    end

    def artifact
      provider.artifact_for(adapter)
    end

    def initialize(adapter, space = nil)
      self.adapter = adapter
      self.space = space
    end

  end
end
