module Spaces
  module Outputting
    class Output

      EOT = 4.chr

      def initialize(command: nil, identifier: nil)
        @command = command
        @identifier = identifier
      end
      attr_reader :command, :identifier

      def write(&block)
        clear
        execute(&block)
      rescue => e
        exception(e)
      ensure
        eot
      end

      def read(&block)
        File.open(filepath, 'r').tap { |file| follow(file, &block) }
      end

      private

      def execute(&block)
        command.execute do |output|
          out(output)
          yield(output) if block_given?
        end
      end

      def clear
        filepath.dirname.mkpath
        File.open(filepath, 'w') {}
      end

      def out(message)
        append({message: message}.to_json)
      end

      def append(line)
        File.open(filepath, 'a') { |f| f.write("#{line}\n") }
      end

      def eot
        append(EOT)
      end

      def exception(e)
        append({exception: exception_message_for(e)}.to_json)
      end

      def exception_message_for(e)
        [e.message, *e.backtrace].join("\n")
      end

      def follow(file)
        select([file])
        loop do
          sleep 0.01
          file.gets.tap do |line|
            next unless line
            return if is_eot?(line)
            yield line
          end
        end
      end

      def is_eot?(line)
        line[0] == EOT
      end

      def filepath_for(*args)
        Space.universes.path.join(*args.map(&:to_s))
      end

    end
  end
end
