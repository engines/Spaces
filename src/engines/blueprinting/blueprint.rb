module Blueprinting
  class Blueprint < Emissions::Emission

    delegate(blueprints: :universe)

    def descriptor; @descriptor ||= blueprints.by(identifier, Spaces::Descriptor) ;end

    def auxiliary_script_file_names
      b.auxiliary_directories.map { |d| blueprints.file_names_for(d.join('scripts'), b.context_identifier) }
    end

  end
end
