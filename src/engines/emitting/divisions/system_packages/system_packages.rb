module Divisions
  class SystemPackages < ::Emissions::KeyedDivision

    def packing_stanza_for(key)
      {
        type: 'shell',
        environment_vars: "SYSTEM_PACKAGE_#{key.upcase}=#{send(key)&.join(' ')}",
        scripts: ["#{packing_script_path}/#{key}"]
      }
    end

    def packing_script_path
      resolutions.file_path_for("packing/scripts/#{qualifier}", context_identifier)
    end

  end
end
