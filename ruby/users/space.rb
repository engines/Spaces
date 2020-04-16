require_relative '../spaces/descriptor'
require_relative '../spaces/space'
require_relative 'user'
require_relative 'incremental_identifier_strategy'

module Users
  class Space < ::Spaces::Space
    include IncrementalIdentifierStrategy

    def identifiers
      super.map { |i| i.split('.').first }  - [increment_file_name]
    end

    def descriptors
      identifiers.map { |i| descriptor_class.new(identifier: i) }
    end

    def save(model)
      model.struct.identifier ||= next_identifier
      super
    end

    def reading_name_for(descriptor, klass = default_model_class)
      "#{path}/#{descriptor.identifier}"
    end

    def writing_name_for(identifier)
      ensure_space
      "#{path}/#{identifier}"
    end

    def default_model_class
      User
    end

    def descriptor_class
      Spaces::Descriptor
    end
  end
end
