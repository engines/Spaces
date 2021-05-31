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
      @packing_divisions ||= [resolution.packing_divisions, scripts_division].flatten.compact
    end

    def scripts_division
      @scripts_division ||=
        if source_path_for(:packing).join('scripts').exist?
          scripts_class.prototype(emission: pack, label: :scripts)
        end
    end

    # PACKER-SPECIFIC
    def packing_artifact; packing_artifacts.map(&:to_h) ;end

    def packing_artifacts
      [auxiliary_files_artifact, precedential_artifact].flatten.compact
    end

    # PACKER-SPECIFIC
    def auxiliary_files_artifact
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

    def precedential_artifact
      complete_precedence.map { |p| artifacts_for(p) }
    end

    def artifacts_for(precedence)
      [file_copy_artifact_for(precedence), division_artifacts_for(precedence)]
    end

    def division_artifacts_for(precedence)
      packing_divisions.map { |d| d.packing_artifact_for(precedence) if d.uses?(precedence) }
    end

    # PACKER-SPECIFIC
    def file_copy_artifact_for(precedence)
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
