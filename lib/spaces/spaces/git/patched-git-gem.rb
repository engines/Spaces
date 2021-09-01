require 'git'

# Monkey patch git gem
# 1. Pass block through to command.
#    The block is for callback to sever-sent events stream.
# 2. Add --verbose and --progress options to clone.
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
  end
  class Lib
    def pull(remote='origin', branch='master', &block)
      debugger
      command('pull', remote, branch, &block)
    end
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
