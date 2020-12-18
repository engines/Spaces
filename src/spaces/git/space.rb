require 'git'

module Git
  class Space < ::Spaces::Space

    def encloses?(descriptor)
      path_for(descriptor).exist?
    end

    def import(descriptor)
      ensure_space
      begin
        g = ::Git.clone(descriptor.repository, descriptor.identifier, path: path)
        g.checkout(descriptor.branch) if descriptor.branch
      rescue ::Git::GitExecuteError => e
        # warn(error: e, descriptor: descriptor, verbosity: [:error])
        just_print_the_error(__FILE__, __LINE__, e)
      end
    end

  end
end
