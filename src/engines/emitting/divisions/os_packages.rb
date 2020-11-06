module Divisions
  class OsPackages < ::Emissions::Division

    def embed(other)
      tap do
        struct.adds = [struct.adds, other.struct.adds].flatten.uniq
      end
    end

    def packing_stanzas
      keys.map { |k| packing_stanza_for(k) }
    end

    def packing_stanza_for(key)
      {
        type: 'shell',
        environment_vars: "BLUEPRINT_PACKAGE_#{key.upcase}='#{send(key)&.join(',')}'",
        scripts: "scripts/shell/package-#{key}"
      }
    end

  end
end
