module Divisions
  class SystemPackages < ::Divisions::Division
    include ::Packing::Division

    def inflated; self ;end
    def deflated; self ;end

    def packing_artifact_for(key)
      {
        type: 'shell',
        environment_vars: "SYSTEM_PACKAGE_#{key.upcase}=#{send(key)&.join(' ')}",
        inline: ["#{temporary_script_path}/#{qualifier}/#{key}"]
      }
    end

  end
end
