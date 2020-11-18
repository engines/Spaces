module Divisions
  class OsPackages < ::Emissions::Division

    def embed(other)
      pp '_' * 88
      pp context_identifier
      pp other.context_identifier
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
      {
        type: 'shell',
        scripts: packing_script_file_names
      }
    end

    def packing_script_file_names
      packing_script_file_name_map.values
    end

    def packing_script_file_name_map
      keys.inject({}) do |m, k|
        m.tap { m[k] = "packing/scripts/packages-#{k}" }
      end
    end

  end
end
