module Associations
  class RoleProvider < ::Targeting::Node

    delegate([:resolutions, :providers] => :universe)

    def provider
      @provider ||= target_from(providers)
    end

    alias_method :node, :provider

    def resolution
      @resolution ||= target_from(resolutions, identifier: resolution_identifier)
    end

    def compute_provider
      @compute_provider ||= target_from(providers, identifier: compute_identifier)
    end

    def resolution_identifier; struct.resolution_identifier ;end
    def compute_identifier; struct.compute_identifier ;end

    def identifier; provider_identifier ;end
    def context_identifier; identifier ;end
    def target_identifier; identifier ;end

  end
end
