require_relative '../../installations/installation'
require_relative '../../installations/collaborator'
require_relative '../../texts/text'

module Docker
  module Files
    class File < ::Installations::Collaborator

      class << self
        def step_group_precedence
          [:first, :early, :anywhere, :late, :last]
        end

        def step_precedence
          {
            early: [:adds],
            late: [:preparations, :templates, :source_protection, :seeds, :installs, :source_persistence],
            last: [:final]
          }
        end

        def inheritance_paths; __dir__; end
      end

      require_files_in :steps

      delegate(
        step_group_precedence: :klass
      )

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

      def path
        klass.identifier
      end

    end
  end
end
