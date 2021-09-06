module Spaces
  module Filing

    # EOT inserted at end of file. This is so that when the client is tailing
    # the file it knows when to stop and close its SSE stream.
    EOT = 4.chr

    def exception_json_for(e)
      {exception: exception_message_for(e)}.to_json
    end

    def exception_message_for(e)
      [e.message, *e.backtrace].join("\n")
    end

    # The :rescue_exceptions option causes exception details to be written
    # to the file. This is useful when logging a command that is running
    # in a different thread to the request thread. The client can display
    # the exception message later, when the output file is retreived.
    def output_to_file(filepath, content_lambda:, rescue_exceptions: false)
      filepath.dirname.mkpath
      clear_file(filepath)
      begin
        content_lambda.call(append_file_lambda_for(filepath))
      rescue => e
        raise e unless rescue_exceptions
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

  end
end
