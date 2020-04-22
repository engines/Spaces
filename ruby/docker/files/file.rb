require_relative '../../installations/installation'
require_relative '../../collaborators/collaborator'
require_relative '../../texts/text'
require_relative 'group_precedence'

module Docker
  module Files
    class File < ::Collaborators::Collaborator
      extend GroupPrecedence

      class << self
        def step_precedence
          {
            early: [:adds],
            late: [:preparations, :source_persistence],
            last: [:final]
          }
        end

        def inheritance_paths; __dir__; end
      end

      require_files_in :steps

      delegate(group_precedence: :klass)

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
        group_precedence.map do |g|
          collaborators.map { |c| c.layers_for(g) }
        end
      end

      def product_path
        klass.identifier
      end

    end
  end
end
