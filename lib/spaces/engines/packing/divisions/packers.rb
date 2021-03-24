require_relative 'division'

module Divisions
  class Packers < ::Divisions::Division
    include ::Packing::Division

    alias_method :pack, :emission

    delegate(
      resolutions: :universe,
      resolution: :pack
    )

    def complete_precedence
      by_precedence(packing_divisions.map(&:keys).flatten.uniq)
    end

    def packing_divisions
      @packing_divisions ||= [resolution.packing_divisions, scripts_division].flatten
    end

    def scripts_division
      @scripts_division ||= scripts_class.prototype(emission: pack, label: :scripts)
    end

    def to_h; packing_stanzas.map(&:to_h) ;end

    def packing_stanzas
      [auxiliary_files_stanzas, precedential_stanzas].flatten.compact
    end

    def auxiliary_files_stanzas
      auxiliary_folders.map do |f|
        if source_path_for(f).exist?
          {
            type: 'file',
            source: "#{source_path_for(f)}/",
            destination: 'tmp'
          }
        end
      end
    end

    def precedential_stanzas
      complete_precedence.map { |p| all_stanzas_for(p) }
    end

    def all_stanzas_for(precedence)
      [file_copy_stanza_for(precedence), division_stanzas_for(precedence)]
    end

    def division_stanzas_for(precedence)
      packing_divisions.map { |d| d.packing_stanza_for(precedence) if d.uses?(precedence) }
    end

    def file_copy_stanza_for(precedence)
      auxiliary_folders.map do |f|
        if copy_source_path_for(f, precedence).exist?
          {
            type: 'shell',
            inline: [
              "chown -R root:root /tmp/#{f}/#{precedence}/",
              "tar -C /tmp/#{f}/#{precedence}/ -cf - . | tar -C / -xf -"
            ]
          }
        end
      end
    end

    def scripts_class; ::Packing::Scripts ;end

  end
end
