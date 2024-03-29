module Spaces
  module Commands
    module Inputs

      def input_for(key, mandatory: true, default: nil) =
        input[key] || default ||
          (mandatory && (raise ::Spaces::Errors::MissingInput, {missing: key, input: input}))

      def identifier = input_for(:identifier)

      def timestamp = input_for(:timestamp, default: "#{Time.now.to_i}")

      def space_identifier(default: nil) = input_for(:space, default: default)

      def stream_identifier = input_for(:stream_identifier)

      def force = input_for(:force, mandatory: false)

      def callback = input_for(:callback, default: default_callback)

    end
  end
end
