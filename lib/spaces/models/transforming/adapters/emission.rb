require_relative 'adapter'

module Adapters
  class Emission < Adapter

    relation_accessor :provider
    relation_accessor :emission

    delegate(
      qualifier: :provider
    )

    def artifact_qualifiers = [:artifact]

    def artifacts
      @artifacts ||= artifact_qualifiers.map do |q|
        artifact_class_for(q)&.new(self)
      end.compact
    end

    def artifact_class_for(artifact_qualifier)
      class_for(naming_elements_for(artifact_qualifier))
    end

    def naming_elements_for(artifact_qualifier) =
      [:artifacts, qualifier, artifact_qualifier].compact

    def compute_qualifier = compute_provider&.qualifier

    def compute_provider
      @compute_provider ||=
        emission.compute_provider_for_identifier(provider.identifier)
    end

    def default_artifact_class = nil

    def declares?(adapters) = adapter_keys.include?(adapters)

    def adapter_keys = []
    def adapter_map = {}

    def initialize(provider, emission)
      self.provider = provider
      self.emission = emission
    end

    def method_missing(m, *args, &block)
      return super if m == :arena
      return arena.send(m, *args, &block) if arena.respond_to?(m)
      super
    end

    def respond_to_missing?(m, *)
      arena.respond_to?(m) || super
    end

  end
end
