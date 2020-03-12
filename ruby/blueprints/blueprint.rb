require_relative '../spaces/model'
require_relative '../installations/installation'

module Blueprints
  class Blueprint < ::Spaces::Model

    class << self
      def subspace_path_method
        :static_identifier
      end
    end

    relation_accessor :installation

    def installation
      @installation ||= installation_class.new(struct: struct)
    end

    def anchor_descriptors
      struct.bindings&.map { |d| descriptor_class.new(d.descriptor) } || []
    end

    def installation_class
      ::Installations::Installation
    end
  end
end
