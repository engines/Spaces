module Associations
  class RoleProviders < ::Targeting::Tree

    def identifiers
      map(&:role_identifier)
    end

    def named(role_identifier)
      all.detect { |rp| rp.role_identifier.to_sym == role_identifier.to_sym }
    end

  end
end
