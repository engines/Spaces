module Divisions
  class Provisioners < ::Emissions::Divisible

    def emit
      # stanzas.map(&:to_h).flatten.compact
    end

    def packing_stanzas
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
