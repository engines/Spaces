module Spaces
  module Filing

    # EOT inserted at end of file. This is to determine when
    # to stop and close when tailing file.
    EOT = 4.chr

    def exception_json_for(e)
      {exception: exception_message_for(e)}.to_json
    end

    def exception_message_for(e)
      [e.message, *e.backtrace].join("\n")
    end

    def output_to_file(filepath, content_lambda:)
      filepath.dirname.mkpath
      clear_file(filepath)
      begin
        content_lambda.call(append_file_lambda_for(filepath))
      rescue => e
        logger.error(e)
        append_file(filepath, "#{exception_json_for(e)}\n")
      ensure
        append_file(filepath, "#{EOT}\n")
      end
    end

    def clear_file(filepath)
      File.open(filepath, 'w') {}
    end

    def append_file(filepath, output)
      File.open(filepath, 'a') do |f|
        f.write(output)
      end
    end

    def append_file_lambda_for(filepath)
      ->(output) {append_file(filepath, output)}
    end

    def tail_file(filepath)
      File.open(filepath, 'r').tap do |file|
        started = false; stopped = false;
        while !stopped do
          sleep 0.01
          file.seek(0,IO::SEEK_SET) unless started
          select([file])
          file.gets.tap do |line|
            next unless line
            started = true
            stopped = line.strip == EOT
            yield line unless stopped
          end
        end
      end
    end

  end
end
