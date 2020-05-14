require_relative 'step'

module Docker
  module Files
    class NativeStep < Step

      delegate(
        [:identifier, :context_identifier] => :context,
        blueprints: :universe
      )

      def instructions
        # @instructions ||=
        begin
          f = File.open(instruction_file_name, 'r')
          f.read
        ensure
          f.close
        end
      end

      def instruction_file_name
        "#{blueprints.file_path_for(:instructions, context_identifier)}/#{identifier}.native"
      end

    end
  end
end
