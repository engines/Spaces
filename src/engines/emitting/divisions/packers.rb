module Divisions
  class Packers < ::Emissions::Division

    alias_method :pack, :emission

    delegate(
      resolutions: :universe,
      [:resolution, :system_packages, :packing] => :pack,
    )

    def emit
      packing_stanzas.map(&:to_h)
    end

    def packing_stanzas
      [auxiliary_files_stanza, system_packages.packing_stanzas, packing.packing_stanzas].compact.flatten
    end

    def auxiliary_files_stanza
      {
        type: 'file',
        source: resolutions.file_path_for(:packing, context_identifier),
        destination: 'tmp/'
      }
    end

    def system_packages_stanzas
      if pack.has?(:system_packages)
        pack.system_packages.packing_stanzas
      end
    end

  end
end
