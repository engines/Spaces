module Arenas
  module Providing

    def provide_for(role_identifier, provider_identifier)
      empty.tap do |m|
        m.struct = struct
        m.struct.tap do |s|
          s.role_providers = [
            OpenStruct.new(role_identifier: role_identifier, provider_identifier: provider_identifier),
            s.role_providers
          ].flatten.uniq(&:role_identifier)
        end
      end
    end

  end
end
