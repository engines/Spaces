module Divisions
  class SystemPackages < ::Emissions::PackingDivision

    def packing_stanza_for(key)
      {
        type: 'shell',
        environment_vars: "SYSTEM_PACKAGE_#{key.upcase}=#{send(key)&.join(' ')}",
        scripts: ["#{temporary_packing_path}/#{key}"]
      }
    end

  end
end
