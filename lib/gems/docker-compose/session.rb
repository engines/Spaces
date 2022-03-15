# Added :stdout to :buffered option.
module Docker::Compose
  class Session

    # Add :stdout to buffered option.
    def initialize(
      shell = Backticks::Runner.new(
        buffered: [:stdout, :stderr],
        interactive: true
      ),
      dir: Dir.pwd,
      file: 'docker-compose.yml'
    )
      @shell = shell
      @dir = dir
      @file = file
      @last_command = nil
    end

    # Add &block to arguments and pass it to run! method.
    # Change default for :detached and :build to true.
    def up(*services,
           abort_on_container_exit: false,
           detached: true, timeout: 10, build: true,
           exit_code_from: nil,
           no_build: false, no_deps: false, no_start: false,
           &block)
      o = opts(
               abort_on_container_exit: [abort_on_container_exit, false],
               d: [detached, false],
               timeout: [timeout, 10],
               build: [build, false],
               exit_code_from: [exit_code_from, nil],
               no_build: [no_build, false],
               no_deps: [no_deps, false],
               no_start: [no_start, false]
      )
      out = run!('up', o, services, &block)
      true
    end

    # Yield IO to a block, if given.
    def run!(*args)
      file_args = case @file
      when 'docker-compose.yml'
        []
      when Array
        file_args = @file.map { |filepath| { :file => filepath } }
      else
        [{ file: @file.to_s }]
      end

      @shell.chdir = dir
      @last_command = @shell.run('docker-compose', *file_args, *args)
      @last_command.tap do |io, bytes|
        yield(io, bytes) if block_given?
        bytes
      end
      @last_command.join
      status = @last_command.status
      out = @last_command.captured_output
      err = @last_command.captured_error
      status.success? || fail(Error.new(args.first, status, out+err))
      out
    end
  end
end
