module Streaming
  module Consuming

    def consume(callback)
      File.open(path, 'r').tap { |f| follow(f, callback) }
    end

    protected

    def follow(file, callback)
      #TODO: Allow reading from end of file, which will be needed for Spaces Events.
      # Something like `file.seek(0, IO::SEEK_END) if tailing_from_end`
      select([file])
      loop do
        sleep 0.001
        file.gets.tap do |line|
          next unless line
          return if is_eot?(line)
          callback.call(line)
        end
      end
    end

    def is_eot?(line) = line[0] == eot

  end
end
