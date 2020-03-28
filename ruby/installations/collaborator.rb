require_relative '../spaces/model'
require_relative '../images/collaboration'
require_relative '../docker/files/collaboration'

module Installations
  class Collaborator < ::Spaces::Model
    include Images::Collaboration
    include Docker::Files::Collaboration

    class << self
      def step_precedence; end

      def script_lot
        files_in(:scripts).map { |f| File.basename(f, '.rb') }
      end

      def require_files_in(folder)
        files_in(folder).each { |f| require f }
      end

      def files_in(folder)
        Dir["#{here}/#{folder}/*"]
      end

      def prototype(installation:, blueprint_label:)
        new(installation: installation, blueprint_label: blueprint_label)
      end
    end

    relation_accessor :installation
    attr_accessor :blueprint_label

    delegate([:home_app_path, :identifier] => :installation)

    def product
      duplicate(struct)
    end

    def initialize(struct: nil, installation: nil, blueprint_label: nil)
      self.installation = installation
      self.blueprint_label = blueprint_label
      self.struct = struct || installation&.struct[blueprint_label] || default
    end

    def default; end

  end
end
