require_relative 'division'

module Divisions
  class Packers < ::Divisions::Division
    include ::Divisions::ProviderDependent
    include ::Packing::Division

    alias_method :pack, :emission

    delegate(
      resolutions: :universe,
      resolution: :pack,
      [:packing_artifact, :auxiliary_file_artifact_for, :file_copy_artifact_for] => :provider_aspect
    )

    def complete_precedence
      by_precedence(packing_divisions.map(&:keys).flatten.uniq)
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

    def packing_artifacts
      [first_artifacts, precedential_artifacts].flatten.compact
    end

    def first_artifacts
      auxiliary_folders.map do |f|
        if (p = source_path_for(f)).exist?
          auxiliary_file_artifact_for(p)
        end
      end.compact
    end

    def precedential_artifacts
      complete_precedence.map { |p| artifacts_for(p) }
    end

    def artifacts_for(precedence)
      [file_copy_artifacts_for(precedence), division_artifacts_for(precedence)]
    end

    def division_artifacts_for(precedence)
      packing_divisions.map { |d| d.packing_artifact_for(precedence) if d.uses?(precedence) }
    end

    def file_copy_artifacts_for(precedence)
      auxiliary_folders.map do |f|
        if copy_source_path_for(f, precedence).exist?
          file_copy_artifact_for(f, precedence)
        end
      end.compact
    end

    def scripts_class; ::Packing::Scripts ;end

  end
end
