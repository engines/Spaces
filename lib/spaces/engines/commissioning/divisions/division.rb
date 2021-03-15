module Commissioning
  module Division

    def precedence; [:first, :early, :adds, :middle, :late, :removes, :last] ;end

    def commissioning_scripts
      precedence.map { |p| paths_for(p) }.flatten.compact.select { |p| p.basename == Pathname('setup.sh')}
    end

    def paths_for(precedence)
      source_paths_for(precedence).map { |p| Pathname("#{p}".split("#{precedence}").last) }
    end

    def source_paths_for(precedence)
      resolutions.file_names_for("#{:commissioning}/#{precedence}", context_identifier)
    end

  end
end
