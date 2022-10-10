module Associations
  class RoleProviders < ::Targeting::Tree

    def identifiers = map(&:role_identifier).map(&:to_sym)
    def provider_identifiers = map(&:provider_identifier).uniq.map(&:to_sym)

    def named(role_identifier) =
      all.detect { |rp| rp.role_identifier.to_sym == role_identifier.to_sym }

    def embedded_with(_) = no_embed_makes_sense

  end
end
