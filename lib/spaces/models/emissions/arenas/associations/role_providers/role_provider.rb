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

    def resolution_identifier = struct.resolution_identifier
    def compute_identifier = struct.compute_identifier

    def identifier = provider_identifier
    def context_identifier = identifier
    def target_identifier = identifier

  end
end
