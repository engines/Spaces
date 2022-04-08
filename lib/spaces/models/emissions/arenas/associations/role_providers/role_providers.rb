module Associations
  class RoleProviders < ::Targeting::Tree

    def named(role_identifier)
      all.detect { |rp| rp.role_identifier == role_identifier }
    end

  end
end
