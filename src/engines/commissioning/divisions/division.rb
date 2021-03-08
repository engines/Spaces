module Commissioning
  module Division

    def precedence; [:first, :early, :adds, :middle, :late, :removes, :last] ;end

    def commissioning_scripts
      precedence.map { |p| paths_for(p) }.flatten.compact
    end

    def paths_for(precedence)
      source_paths_for(precedence).map { |p| Pathname("#{p}".split("#{precedence}").last) }
    end

    def source_paths_for(precedence)
      resolutions.file_names_for("#{:commissioning}/#{precedence}", context_identifier)
    end

    # def uses?(precedence); keys.include?(precedence.to_sym) ;end
    #
    # def keys; by_precedence(super) ;end
    #
    # def by_precedence(keys)
    #   keys.sort_by { |k| precedence.index(k) || precedence_midpoint }
    # end

    # def precedence_midpoint; precedence.count / 2 ;end

  end
end
