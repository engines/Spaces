require_relative '../spaces/model'
require_relative '../images/collaboration'
require_relative '../docker/files/collaboration'

module Installations
  class Collaborator < ::Spaces::Model
    include Images::Collaboration
    include Docker::Files::Collaboration

    class << self
      def prototype(installation:, blueprint_label:)
        new(installation: installation, blueprint_label: blueprint_label)
      end
    end

    relation_accessor :installation

    delegate([:home_app_path, :identifier] => :installation)

    def product
      duplicate(struct)
    end

    def initialize(struct: nil, installation: nil, blueprint_label: nil)
      self.installation = installation
      self.struct = struct || installation&.struct[blueprint_label] || default
    end

    def default; end

  end
end
