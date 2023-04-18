module Git
  class Base

    # Redefine existing method.
    #  Add &block as argument for passing down to command.
    def self.clone(repository_url, directory, options = {}, &block)
      new_options = Git::Lib.new(nil, options[:log]).clone(repository_url, directory, options)
      normalize_paths(new_options, bare: options[:bare] || options[:mirror])
      new(new_options, &block)
    end

    # Redefine existing method.
    #  Add &block as argument for passing down to command.
    #  Add opts
    def pull(remote = nil, branch = nil, opts = {}, &block)
      self.lib.pull(remote, branch, opts, &block)
    end

    # Redefine existing method.
    #  Add &block as argument for passing down to command.
    def push(*args, **options, &block)
      self.lib.push(*args, **options, &block)
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
