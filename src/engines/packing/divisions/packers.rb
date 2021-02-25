require_relative 'division'

module Divisions
  class Packers < ::Divisions::Division
    include ::Packing::Division

    alias_method :pack, :emission

    delegate(
      resolutions: :universe,
      resolution: :pack
    )

    def to_h; packing_stanzas.map(&:to_h) ;end

    def packing_stanzas
      [auxiliary_files_stanza, precedential_stanzas]
        .compact.flatten
    end

    def precedential_stanzas
      complete_precedence.map { |p| all_stanzas_for(p) }
    end

    def all_stanzas_for(precedence)
      [
        (file_copy_stanza_for(precedence) if copy_source_path_for(precedence).exist?),
        division_stanzas_for(precedence)
      ].flatten.compact
    end

    def division_stanzas_for(precedence)
      packing_divisions.map { |d| d.packing_stanza_for(precedence) if d.uses?(precedence) }
        .compact.flatten
    end

    def complete_precedence
      by_precedence(packing_divisions.map(&:keys).flatten.uniq)
    end

    def packing_divisions
      @packing_divisions ||= [resolution.packing_divisions, scripts_division].flatten
    end

    def scripts_division
      @scripts_division ||= scripts_class.prototype(emission: pack, label: :scripts)
    end

    def scripts_class; ::Packing::Scripts ;end

    def auxiliary_files_stanza
      {
        type: 'file',
        source: "#{packing_source_path}/",
        destination: 'tmp'
      }
    end

    def file_copy_stanza_for(precedence)
      {
        type: 'shell',
        inline: [
          "chown -R root:root /tmp/packing/#{precedence}/",
          "tar -C /tmp/packing/#{precedence}/ -cf - . | tar -C / -xf -"
        ]
      }
    end

  end
end
