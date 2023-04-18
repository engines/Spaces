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
    def pull(remote = nil, branch = nil, opts = {}, &block)
      raise ArgumentError, "You must specify a remote if a branch is specified" if remote.nil? && !branch.nil?

      arr_opts = []
      arr_opts << remote if remote
      arr_opts << branch if branch
      arr_opts << "--verbose" if opts[:verbose]
      arr_opts << "--progress" if opts[:progress]

      command('pull', *arr_opts, &block)
    end

    # Redefine existing method.
    #  Add &block as argument for passing down to command.
    #  Add --verbose and --progress options.
    def clone(repository_url, directory, opts = {}, &block)
      @path = opts[:path] || '.'
      clone_dir = opts[:path] ? File.join(@path, directory) : directory

      arr_opts = []
      arr_opts << '--bare' if opts[:bare]
      arr_opts << '--branch' << opts[:branch] if opts[:branch]
      arr_opts << '--depth' << opts[:depth].to_i if opts[:depth] && opts[:depth].to_i > 0
      arr_opts << '--filter' << opts[:filter] if opts[:filter]
      Array(opts[:config]).each { |c| arr_opts << '--config' << c }
      arr_opts << '--origin' << opts[:remote] || opts[:origin] if opts[:remote] || opts[:origin]
      arr_opts << '--recursive' if opts[:recursive]
      arr_opts << '--mirror' if opts[:mirror]
      arr_opts << "--verbose" if opts[:verbose]
      arr_opts << "--progress" if opts[:progress]

      arr_opts << '--'

      arr_opts << repository_url
      arr_opts << clone_dir

      command('clone', *arr_opts, &block)

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

      if opts[:gpg_sign] && opts[:no_gpg_sign]
        raise ArgumentError, 'cannot specify :gpg_sign and :no_gpg_sign'
      elsif opts[:gpg_sign]
        arr_opts <<
          if opts[:gpg_sign] == true
            '--gpg-sign'
          else
            "--gpg-sign=#{opts[:gpg_sign]}"
          end
      elsif opts[:no_gpg_sign]
        arr_opts << '--no-gpg-sign'
      end

      command('commit', *arr_opts, &block)
    end


    # Redefine existing method.
    #  Add &block as argument for passing down to command.
    #  Add --verbose and --progress options.
    def push(remote = nil, branch = nil, opts = nil, &block)
      if opts.nil? && branch.instance_of?(Hash)
        opts = branch
        branch = nil
      end

      if opts.nil? && remote.instance_of?(Hash)
        opts = remote
        remote = nil
      end

      opts ||= {}

      # Small hack to keep backwards compatibility with the 'push(remote, branch, tags)' method signature.
      opts = {:tags => opts} if [true, false].include?(opts)

      raise ArgumentError, "You must specify a remote if a branch is specified" if remote.nil? && !branch.nil?

      arr_opts = []
      arr_opts << '--mirror'  if opts[:mirror]
      arr_opts << '--delete'  if opts[:delete]
      arr_opts << '--force'  if opts[:force] || opts[:f]
      arr_opts << "--verbose" if opts[:verbose]
      arr_opts << "--progress" if opts[:progress]
      Array(opts[:push_option]).each { |o| arr_opts << '--push-option' << o } if opts[:push_option]
      arr_opts << remote if remote
      arr_opts_with_branch = arr_opts.dup
      arr_opts_with_branch << branch if branch

      if opts[:mirror]
          command('push', *arr_opts_with_branch, &block)
      else
          command('push', *arr_opts_with_branch, &block)
          command('push', '--tags', *arr_opts, &block) if opts[:tags]
      end
    end

  end
end
