module Arenas
  module Providing

    def compute_resolutions_for(identifier)
      directly_bound_resolutions.select do |r|
        r.provides_compute_service_for?(identifier)
      end
    end

    def perform?(role_identifier)
      role_identifiers.include?(role_identifier.to_sym)
    end

    def role_identifiers
      role_providers.identifiers
    end

    def providers
      role_providers.map(&:provider).uniq(&:identifier)
    end

    def provider_for(role_identifier)
      role_providers.named(role_identifier)&.provider
    end

    def qualifier_for(role_identifier)
      provider_for(role_identifier)&.qualifier
    end

    def resolution_for(role_identifier)
      provider_for(role_identifier)&.resolution
    end

    def role_for(provider_identifier)
      role_providers.detect do |rp|
        rp.provider_identifier.to_sym == provider_identifier.to_sym
      end
    end

    def compute_provider_for(provider_identifier)
      role_for(provider_identifier)&.compute_provider
    end

    def compute_provider
      role_providers.orchestration&.compute_provider
    end

    def compute_repository_path
      "#{compute_provider.repository_domain}/#{container_registry.application_identifier}"
    end

  end
end
