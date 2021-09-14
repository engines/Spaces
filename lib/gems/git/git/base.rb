module Git
  class Base

    # Redefine existing method.
    #  Add &block as argument for passing down to command.
    #  Rename options to opts, to be consistent with other methods.
    def self.clone(repository, name, opts = {}, &block)
      self.new(Git::Lib.new(nil, opts[:log]).clone(repository, name, opts, &block))
    end

    # Redefine existing method.
    #  Add &block as argument for passing down to command.
    # Add opts
    def pull(remote='origin', branch='master', opts = {}, &block)
      self.lib.pull(remote, branch, opts, &block)
    end

    # Redefine existing method.
    #  Add &block as argument for passing down to command.
    def push(remote = 'origin', branch = 'master', opts = {}, &block)
      opts = {:tags => opts} if [true, false].include?(opts)
      self.lib.push(remote, branch, opts, &block)
    end

    # Redefine existing method.
    #  Add &block as argument for passing down to command.
    def commit_all(message, opts = {}, &block)
      opts = {:add_all => true}.merge(opts)
      self.lib.commit(message, opts, &block)
    end

    # New method.
    def branch_move_to(branch = 'master')
      self.lib.branch_move_to(branch)
    end

  end
end
