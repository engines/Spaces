module Divisions
  class SystemPackages < ::Divisions::Division
    include ::Packing::Division

    def packing_payload_for(key)
      {
        type: 'shell',
        environment_vars: "SYSTEM_PACKAGE_#{key.upcase}=#{send(key)&.join(' ')}",
        inline: ["#{temporary_script_path}/#{qualifier}/#{key}"]
      }
    end

  end
end
