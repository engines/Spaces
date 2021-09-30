require_relative 'division'

module Divisions
  class Packers < ::Divisions::Division
    include ::Packing::Division

    alias_method :pack, :emission

    delegate(
      resolutions: :universe,
      resolution: :pack,
      [:packing_stanza, :auxiliary_file_stanza_for, :file_copy_stanza_for] => :provider_aspect
    )

    def complete_precedence
      by_precedence([precedence, packing_divisions.map(&:keys)].flatten.uniq)
    end

    def packing_divisions
      @packing_divisions ||= [resolution.packing_divisions, scripts_division].flatten.compact
    end

    def scripts_division
      @scripts_division ||=
        if source_path_for(:packing).join('scripts').exist?
          scripts_class.prototype(emission: pack, label: :scripts)
        end
    end

    def packing_stanzas
      [first_stanzas, precedential_stanzas].flatten.compact
    end

    def first_stanzas
      auxiliary_folders.map do |f|
        if (p = source_path_for(f)).exist?
          auxiliary_file_stanza_for(p)
        end
      end.compact
    end

    def precedential_stanzas
      complete_precedence.map { |p| stanzas_for(p) }
    end

    def stanzas_for(precedence)
      [file_copy_stanzas_for(precedence), division_stanzas_for(precedence)]
    end

    def division_stanzas_for(precedence)
      packing_divisions.map { |d| d.packing_stanza_for(precedence) if d.uses?(precedence) }
    end

    def file_copy_stanzas_for(precedence)
      auxiliary_folders.map do |f|
        if copy_source_path_for(f, precedence).exist?
          file_copy_stanza_for(f, precedence)
        end
      end.compact
    end

    def scripts_class; ::Packing::Scripts ;end

  end
end
