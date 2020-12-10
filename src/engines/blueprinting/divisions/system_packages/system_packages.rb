module Divisions
  class SystemPackages < ::Emissions::Division
    include ::Packing::Division

    def packing_stanza_for(key)
      {
        type: 'shell',
        environment_vars: "SYSTEM_PACKAGE_#{key.upcase}=#{send(key)&.join(' ')}",
        scripts: ["#{temporary_packing_path}/#{key}"]
      }
    end

  end
end
