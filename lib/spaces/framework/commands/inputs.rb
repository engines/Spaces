module Spaces
  module Commands
    module Inputs

      def input_for(key, mandatory: true, default: nil)
        input[key] || default ||
          (mandatory && (raise ::Spaces::Errors::MissingInput, {missing: key, input: input}))
      end

      def identifier
        input_for(:identifier)
      end

      def space_identifier(default: nil)
        input_for(:space, default: default)
      end

      def stream_identifier
        input_for(:stream_identifier)
      end

      def force
        input_for(:force, mandatory: false)
      end

      def callback
        input_for(:callback)
      end

    end
  end
end
