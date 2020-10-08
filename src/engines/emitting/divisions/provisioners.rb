module Divisions
  class Provisioners < ::Emissions::Division

    delegate(script_file_names: :emission)

    def emit
      packing_stanzas.map(&:to_h)
    end

    def packing_stanzas
      [injection_stanza, scripts_stanza].compact.flatten
    end

    def injection_stanza
      {
        type: 'file',
        source: 'injections',
        destination: 'tmp/'
      }
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
