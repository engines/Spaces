module Spaces
  module Commands
    class Space < ::Spaces::PathSpace

      class << self
        def default_model_class = Command
      end

      def summaries(space_identifier:) =
        all(space_identifier: space_identifier).map(&:input)

      def all(space_identifier:)
        identifiers(space_identifier: space_identifier).map do |i|
          by(i)
        end.compact
      end

      def identifiers(space_identifier: '*')
        path.glob("#{space_identifier}/*").map do |p|
          "#{p.relative_path_from(path).without_ext}".as_compound
        end
      end

      def reading_path_for(identifiable, _) =
        path.join(identifiable.identifier.as_path)

      def writing_path_for(command) =
        path.join("#{command.space.identifier}")

    end
  end
end
