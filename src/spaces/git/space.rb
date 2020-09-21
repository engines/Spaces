require 'git'
require_relative '../models/space'

module Git
  class Space < ::Spaces::Space

    def encloses?(descriptor)
      Dir.exist?(path_for(descriptor))
    end

    def import(descriptor)
      ensure_space
      begin
        g = ::Git.clone(descriptor.repository, descriptor.identifier, path: path)
        g.checkout(descriptor.branch) if descriptor.branch
      rescue ::Git::GitExecuteError => e
        warn(error: e, descriptor: descriptor, verbosity: [:error])
      end
    end

  end
end
