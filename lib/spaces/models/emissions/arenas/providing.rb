module Arenas
  module Providing

    def compute_resolutions_for(identifier)
      directly_bound_resolutions.select do |r|
        r.provides_compute_service_for?(identifier)
      end
    end

    def perform?(role_identifier) =
      role_identifiers.include?(role_identifier.to_sym)

    def role_identifiers = role_providers.identifiers
    def provider_identifiers = role_providers.provider_identifiers

    def providers =
      role_providers.map(&:provider).uniq(&:identifier)

    def provider_for(role_identifier) =
      role_providers.named(role_identifier)&.provider

    def qualifier_for(role_identifier) =
      provider_for(role_identifier)&.qualifier

    def resolution_for(role_identifier) =
      provider_for(role_identifier)&.resolution

    def role_for(provider_identifier)
      role_providers.detect do |rp|
        rp.provider_identifier.to_sym == provider_identifier.to_sym
      end
    end

    def compute_provider_for(provider_identifier) =
      role_for(provider_identifier)&.compute_provider

    def compute_provider =
      role_providers.named(:orchestration)&.compute_provider

    def compute_repository_path =
      "#{compute_provider.repository_domain}/#{container_registry.application_identifier}"

  end
end
