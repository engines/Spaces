module Divisions
  class Packers < ::Emissions::Division

    alias_method :pack, :emission

    delegate([:os_packages, :script_file_names] => :pack)

    def emit
      packing_stanzas.map(&:to_h)
    end

    def packing_stanzas
      [injection_stanza, scripts_stanza, os_packages.packing_stanzas].compact.flatten
    end

    def injection_stanza
      {
        type: 'file',
        source: 'injections',
        destination: 'tmp/'
      }
    end

    def os_packages_stanzas
      if pack.has?(:os_packages)
        pack.os_packages.packing_stanzas
      end
    end

    def scripts_stanza
      if script_file_names.any?
        [
          {
            type: 'file',
            source: 'scripts/',
            destination: 'tmp'
          },
          {
            type: 'shell',
            scripts: script_file_names
          }
        ]
      end
    end

  end
end
