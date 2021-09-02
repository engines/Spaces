require 'git'

# Monkey patch git gem
module Git
  def self.clone(repository, name, options = {}, &block)
    Base.clone(repository, name, options, &block)
  end
  class Base
    def self.clone(repository, name, options = {}, &block)
      self.new(Git::Lib.new(nil, options[:log]).clone(repository, name, options, &block))
    end
    def pull(remote='origin', branch='master', &block)
      self.lib.pull(remote, branch, &block)
    end
    # New method.
    def branch_move_to(branch = 'master')
      self.lib.branch_move_to(branch)
    end
  end
  class Branch
    def checkout(opts = {})
      check_if_create unless opts[:new_branch]
      @base.checkout(@full, opts)
    end
    # New method.
    def move(branch)
      @base.branch_move_to(branch)
    end
  end
  class Lib
    # New method.
    def branch_move_to(branch)
      command('branch', '-M', branch)
    end
    # Redefine existing method.
    #  Add &block as arguments for passing down to command.
    def pull(remote='origin', branch='master', &block)
      command('pull', remote, branch, &block)
    end
    # Redefine existing method.
    #  Add &block as arguments for passing down to command.
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
  end
end
