module Divisions
  class Packers < ::Emissions::PackingDivision

    alias_method :pack, :emission

    delegate(
      resolutions: :universe,
      resolution: :pack,
      packing_divisions: :resolution
    )

    def emit
      packing_stanzas.map(&:to_h)
    end

    def packing_stanzas
      [auxiliary_files_stanza, precedential_stanzas]
        .compact.flatten
    end

    def precedential_stanzas
      complete_precedence.map { |p| all_stanzas_for(p) }
    end

    def all_stanzas_for(precedence)
      packing_divisions.map { |d| d.packing_stanza_for(precedence) if d.respond_to?(precedence) }
        .compact.flatten
    end

    def complete_precedence; by_precedence(packing_divisions.map(&:keys).flatten.uniq) ;end

    def auxiliary_files_stanza
      {
        type: 'file',
        source: resolutions.file_path_for(:packing, context_identifier),
        destination: 'tmp/'
      }
    end

  end
end
