module Divisions
  class SystemPackages < ::Emissions::KeyedDivision

    def packing_stanza_for(key)
      {
        type: 'shell',
        environment_vars: "SYSTEM_PACKAGE_#{key.upcase}=#{send(key)&.join(' ')}",
        scripts: ["#{packing_script_path}/#{key}"]
      }
    end

  end
end
