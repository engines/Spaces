module Blueprinting
  class Blueprint < Emissions::Emission

    delegate(blueprints: :universe)

    def descriptor; @descriptor ||= blueprints.by(identifier, Spaces::Descriptor) ;end

    def auxiliary_script_file_names
      [itself, embeds].flatten.reverse.map do |b|
        b.auxiliary_directories.map { |d| blueprints.file_names_for(d.join('scripts'), b.context_identifier) }
      end.flatten
    end

    def initialize(struct: nil, identifier: nil)
      super(struct: struct)
      self.struct.identifier = identifier if identifier
    end

  end
end
