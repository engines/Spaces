module Git
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
end
