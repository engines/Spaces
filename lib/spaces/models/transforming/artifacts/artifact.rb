require_relative 'content'

module Artifacts
  class Artifact < ::Spaces::Model
    include ::Transforming::Precedence
    include Content

    relation_accessor :holder

    alias_method :adapter, :holder
    alias_method :content, :text_content

    delegate(
      [:provider, :adapter_map, :adapter_keys] => :adapter
    )

    def provider_qualifiers =
      # TODO: refactor this long method chain
      arena.role_providers.map(&:provider).map(&:qualifier).uniq - [provider.qualifier]

    def compute_service_identifier =
      resolution.compute_service&.identifier

    def compute_identifier = role.compute_identifier

    def role = resolution.role_for(provider.identifier)

    def filename = qualifier

    def initialize(holder)
      self.holder = holder
    end

    def method_missing(m, *args, &block)
      return adapter_map[m] if adapter_keys.include?(m)
      return holder.send(m, *args, &block) if holder.respond_to?(m)
      super
    end

    def respond_to_missing?(m, *)
      adapter_map.include?(m) || holder.respond_to?(m) || super
    end

  end
end
