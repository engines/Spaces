require 'git'

module Git
  class Space < ::Spaces::Space

    def encloses?(descriptor)
      path_for(descriptor).exist?
    end

    def import(descriptor)
      ensure_space
      begin
        g = ::Git.clone(repository(descriptor), descriptor.identifier, path: path)
        g.checkout(branch(descriptor)) if branch(descriptor)
      rescue ::Git::GitExecuteError => e
        warn(error: e, descriptor: descriptor, verbosity: [:error])
      end
    end

    def repository(descriptor)
      fork_account ? "#{descriptor.repository}".gsub(default_account, fork_account): descriptor.repository
    end

    def branch(descriptor)
      descriptor.branch
    end

    def default_account; 'v2Blueprints' ;end
    def fork_account
      # 'MarkRatjens'
      default_account
    end

  end
end
