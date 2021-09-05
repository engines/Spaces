module Spaces
  module Filing

    def file_output_from(command, filepath, opts={})
      begin
        # NOTE: Intentionally opening and closing file on each write of data.
        # This is so that file can be tailed and read in another thread.
        send(command) do |output|
          File.open(filepath, 'a') { |f| f.write(output) }
        end
      rescue => e
        raise e unless opts[:thread]
        # When filing output in a thread, write any exception details
        # to the file so that the client can display the exception when the output file is shown.
        logger.error(e)
        File.open(filepath, 'a') { |f| f.write("#{{exception: [e.message, *e.backtrace].join("\n")}.to_json}\n") }
      ensure
        File.open(filepath, 'a') { |f| f.write("#{4.chr}\n\n") } # ascii 04 is EOT
      end
    end

    def clear_file(build_filepath)
      File.open(build_filepath, 'w') {}
    end

  end
end
