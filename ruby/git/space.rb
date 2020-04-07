require 'git'
require_relative '../spaces/space'

module Git
  class Space < ::Spaces::Space

    def by(descriptor)
      f = File.open(reading_name_for(descriptor), 'r')
      begin
        f.read
      ensure
        f.close
      end
    end

    def encloses?(descriptor)
      Dir.exist?(path_for(descriptor))
    end

    def reading_name_for(descriptor, klass = nil)
      ensure_space
      Dir["#{path_for(descriptor)}/*.json"].first
    end

    def import(descriptor)
      ensure_space
      begin
        g = ::Git.clone(descriptor.repository, descriptor.project_identifier, path: path)
        g.checkout(descriptor.branch) if descriptor.branch
      rescue ::Git::GitExecuteError
      end
    end

  end
end
