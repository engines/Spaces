module Git
  class Lib

    # New method.
    def branch_move_to(branch)
      command('branch', '-M', branch)
    end

    # Redefine existing method.
    #  Add &block as argument for passing down to command.
    #  Add opts argument
    #  Add --verbose and --progress options.
    def pull(remote='origin', branch='master', opts = {}, &block)
      arr_opts = []
      arr_opts << "--verbose" if opts[:verbose]
      arr_opts << "--progress" if opts[:progress]

      command('pull', remote, branch, arr_opts, &block)
    end

    # Redefine existing method.
    #  Add &block as argument for passing down to command.
    #  Add --verbose and --progress options.
    def clone(repository, name, opts = {}, &block)
      @path = opts[:path] || '.'
      clone_dir = opts[:path] ? File.join(@path, name) : name

      arr_opts = []
      arr_opts << '--bare' if opts[:bare]
      arr_opts << '--branch' << opts[:branch] if opts[:branch]
      arr_opts << '--depth' << opts[:depth].to_i if opts[:depth] && opts[:depth].to_i > 0
      arr_opts << '--config' << opts[:config] if opts[:config]
      arr_opts << '--origin' << opts[:remote] || opts[:origin] if opts[:remote] || opts[:origin]
      arr_opts << '--recursive' if opts[:recursive]
      arr_opts << "--mirror" if opts[:mirror]
      arr_opts << "--verbose" if opts[:verbose]
      arr_opts << "--progress" if opts[:progress]

      arr_opts << '--'

      arr_opts << repository
      arr_opts << clone_dir

      command('clone', arr_opts, &block)

      return_base_opts_from_clone(clone_dir, opts)
    end

    # Redefine existing method.
    #  Add &block as argument for passing down to command.
    #  Add --verbose and --progress options.
    def commit(message, opts = {}, &block)
      arr_opts = []
      arr_opts << "--message=#{message}" if message
      arr_opts << '--amend' << '--no-edit' if opts[:amend]
      arr_opts << '--all' if opts[:add_all] || opts[:all]
      arr_opts << '--allow-empty' if opts[:allow_empty]
      arr_opts << "--author=#{opts[:author]}" if opts[:author]
      arr_opts << "--date=#{opts[:date]}" if opts[:date].is_a? String
      arr_opts << '--no-verify' if opts[:no_verify]
      arr_opts << '--allow-empty-message' if opts[:allow_empty_message]
      arr_opts << "--verbose" if opts[:verbose]
      arr_opts << "--progress" if opts[:progress]

      if opts[:gpg_sign]
        arr_opts <<
        if opts[:gpg_sign] == true
          '--gpg-sign'
        else
          "--gpg-sign=#{opts[:gpg_sign]}"
        end
      end

      command('commit', arr_opts, &block)
    end

    # Redefine existing method.
    #  Add &block as argument for passing down to command.
    #  Add --verbose and --progress options.
    def push(remote, branch = 'master', opts = {}, &block)
      opts = {:tags => opts} if [true, false].include?(opts)

      arr_opts = []
      arr_opts << '--mirror'  if opts[:mirror]
      arr_opts << '--delete'  if opts[:delete]
      arr_opts << '--force'  if opts[:force] || opts[:f]
      arr_opts << "--verbose" if opts[:verbose]
      arr_opts << "--progress" if opts[:progress]
      arr_opts << remote

      if opts[:mirror]
          command('push', arr_opts, &block)
      else
          command('push', arr_opts + [branch], &block)
          command('push', ['--tags'] + arr_opts, &block) if opts[:tags]
      end
    end

  end
end
