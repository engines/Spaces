require_relative 'adapter'

module Adapters
  class Emission < Adapter

    relation_accessor :provider
    relation_accessor :emission

    delegate(qualifier: :provider)

    def artifact_qualifiers
      [:artifact]
    end

    def artifacts
      @artifacts ||= artifact_qualifiers.map do |q|
        artifact_class_for(q).new(self)
      end
    end

    def artifact_class_for(artifact_qualifier)
      class_for(:artifacts, qualifier, artifact_qualifier)
    rescue NameError
      default_artifact_class
    end

    def default_artifact_class; ::Artifacts::Artifact ;end

    def adapter_keys; [] ;end
    def adapter_map; {} ;end

    def initialize(provider, emission)
      self.provider = provider
      self.emission = emission
    end

    def method_missing(m, *args, &block)
      return arena.send(m, *args, &block) if arena.respond_to?(m)
      super
    end

    def respond_to_missing?(m, *)
      arena.respond_to?(m) || super
    end

  end
end
