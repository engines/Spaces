module Associations
  class RoleProviders < ::Divisions::Divisible

    def for_role(role_identifier)
      all.detect { |rp| rp.role_identifier == role_identifier }
    end

  end
end
