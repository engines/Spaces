require_relative '../spaces/model'

module Projects
  class Blueprint < ::Spaces::Model

    delegate(project_identifier: :descriptor)

    alias_method :identifier, :project_identifier

    def anchor_descriptors
      struct.bindings&.map { |d| descriptor_class.new(d.descriptor) } || []
    end
  end
end
