module Arenas
  module Providing

    def providers
      role_providers.map(&:provider)
    end

    def provider_for(role_identifier)
      role_providers.named(role_identifier)&.provider
    end

    def qualifier_for(role_identifier)
      provider_for(role_identifier).qualifier
    end

    def resolution_for(role_identifier)
      provider_for(role_identifier).resolution
    end

  end
end
