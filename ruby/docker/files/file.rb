require_relative '../../installations/installation'
require_relative '../../installations/collaborator'
require_relative '../../texts/text'

module Docker
  module Files
    class File < ::Installations::Collaborator

      Dir["#{__dir__}/steps/*"].each { |f| require f }

      class << self
        def collaboration_precedence
          @@collaboration_precedence ||= [:framework, :environment, :domain, :bindings, :os_packages, :nodules, :packages, :file_permissions, :persistent_dirs, :persistent_files, :docker_file]
        end

        def step_group_precedence
          @@step_group_precedence ||= [:first, :early, :anywhere, :late, :last]
        end

        def step_precedence
          @@docker_file_step_precedence ||= {
            early: [:adds],
            late: [:preparations, :templates, :source_protection, :seeds, :installs, :source_persistence],
            last: [:final]
          }
        end
      end

      def collaboration_precedence
        self.class.collaboration_precedence
      end

      def step_group_precedence
        self.class.step_group_precedence
      end

      def product
        text_class.new(source: source, context: self).resolved
      end

      def text_class
        Texts::Text
      end

      def source
        layers.flatten.compact.join("\n")
      end

      def layers
        step_group_precedence.map do |g|
          collaborators.map { |c| c.layers_for(g) }
        end
      end

      def collaborators
        collaboration_precedence.map { |c| installation.send(c) }.compact
      end

      def path
        self.class.identifier
      end

    end
  end
end
