require_relative 'product'

module Collaborators
  class Collaborator < Product

    class << self
      def prototype(installation:, blueprint_label:)
        new(installation: installation, blueprint_label: blueprint_label)
      end
    end

    relation_accessor :installation
    attr_accessor :blueprint_label

    delegate([:home_app_path, :context_identifier] => :installation)

    def collaborators
      @collaborators ||= installation.collaborators.values.compact
    end

    def initialize(struct: nil, installation: nil, blueprint_label: nil)
      self.installation = installation
      self.blueprint_label = blueprint_label
      self.struct = struct || installation&.struct[blueprint_label] || default
    end

    def default; end

  end
end
