require_relative '../spaces/model'
require_relative '../images/collaboration'
require_relative '../docker/files/collaboration'

module Installations
  class Collaborator < ::Spaces::Model
    include Images::Collaboration
    include Docker::Files::Collaboration

    class << self
      def prototype(installation:, section:)
        new(installation: installation, section: section)
      end
    end

    relation_accessor :installation

    def product
      duplicate(struct)
    end

    def home_app_path
      installation.home_app_path
    end

    def identifier
      installation.identifier
    end

    def initialize(struct: nil, installation: nil, section: nil)
      self.installation = installation
      self.struct = struct || installation&.struct[section] || default
    end

    def default; end

  end
end
