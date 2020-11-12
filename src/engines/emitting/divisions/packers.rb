module Divisions
  class Packers < ::Emissions::Division

    alias_method :pack, :emission

    delegate([:os_packages, :script_file_names] => :pack)

    def emit
      packing_stanzas.map(&:to_h)
    end

    def packing_stanzas
      [auxiliary_files_stanza].compact.flatten
    end

    def auxiliary_files_stanza
      {
        type: 'file',
        source: pack.resolution.resolutions.file_path_for(:packing, context_identifier),
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
