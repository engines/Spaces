require_relative 'step'

module Docker
  module Files
    class NativeStep < Step

      delegate(
        [:identifier, :context_identifier] => :context,
        blueprints: :universe
      )

      def instructions
        @instructions ||= ::File.read(instruction_file_name)
      end

      def instruction_file_name
        "#{blueprints.file_path_for(:instructions, context_identifier)}/#{identifier}.native"
      end

    end
  end
end
