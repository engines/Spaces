require_relative 'collaboration'

module Releases
  class Release < Collaboration

    delegate(blueprints: :universe)

    alias_method :has?, :respond_to?

    def count
      has?(:scaling) ? scaling.count : 1
    end

    def descriptors_for(division_identifier)
      descriptors_structs_for(division_identifier).map { |d| descriptor_class.new(d) }.uniq(&:uniqueness)
    end

    def descriptors_structs_for(division_identifier)
      (struct[division_identifier] || []).map { |d| d[:descriptor] }.compact
    end

    def blueprint_file_names_for(directory)
      blueprints.file_names_for(directory, context_identifier)
    end

    def text_class; Texts::FileText ;end

  end
end
