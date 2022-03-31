module Associations
  class RoleProvider < ::Targeting::Node

    delegate(providers: :universe)

    def provider; @provider ||= target_from(providers) ;end

    alias_method :node, :provider

    def identifier; provider_identifier ;end
    def context_identifier; identifier ;end
    def target_identifier; identifier ;end

  end
end
