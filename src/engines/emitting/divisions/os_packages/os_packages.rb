module Divisions
  class OsPackages < ::Emissions::Division

    delegate(resolutions: :universe)

    def embed(other)
      tap do
        keys_including(other).each do |k|
          struct[k] = [struct[k], other.struct[k]].flatten.compact.uniq
        end
      end
    end

    def keys_including(other)
      [keys, other.keys].flatten.uniq
    end

    def packing_stanzas
       keys.map { |k| packing_stanza_for(k) }
    end

    def packing_stanza_for(key)
      {
        type: 'shell',
        environment_vars: "BLUEPRINT_PACKAGE_#{key.upcase}=#{send(key)&.join(' ')}",
        scripts: ["#{packing_script_path}/#{key}"]
      }
    end

    def packing_script_path
      resolutions.file_path_for("packing/scripts/#{qualifier}", context_identifier)
    end

  end
end
