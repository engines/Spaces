require_relative 'precedence'

module Divisions
  class Packers < ::Divisions::Division
    include ::Packing::Division

    alias_method :pack, :emission

    delegate(
      resolutions: :universe,
      resolution: :pack,
      [:packing_snippet, :auxiliary_file_snippet_for, :file_copy_snippet_for] => :provider_division_aspect
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

    def packing_snippets
      [first_snippets, precedential_snippets].flatten.compact
    end

    def first_snippets
      auxiliary_folders.map do |f|
        if (p = source_path_for(f)).exist?
          auxiliary_file_snippet_for(p)
        end
      end.compact
    end

    def precedential_snippets
      complete_precedence.map { |p| snippets_for(p) }
    end

    def snippets_for(precedence)
      [file_copy_snippets_for(precedence), division_snippets_for(precedence)]
    end

    def division_snippets_for(precedence)
      packing_divisions.map { |d| d.packing_snippet_for(precedence) if d.uses?(precedence) }
    end

    def file_copy_snippets_for(precedence)
      auxiliary_folders.map do |f|
        if copy_source_path_for(f, precedence).exist?
          file_copy_snippet_for(f, precedence)
        end
      end.compact
    end

    def scripts_class; ::Packing::Scripts ;end

  end
end
