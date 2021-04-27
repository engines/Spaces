require 'git'

module Spaces
  module Git
    class Repository < ::Spaces::Model
      include Engines::Logger

      relation_accessor :descriptor
      relation_accessor :space

      def by_import(force: false)
        if space.imported?(descriptor)
          pull_remote if force
        else
          clone_remote
        end

        space.by(descriptor)
      end

      delegate([:repository_name, :identifier, :branch_name] => :descriptor)

      def clone_remote
        git.clone(repository_name, identifier, branch: branch_name, path: space.path, depth: 0)
      rescue ::Git::GitExecuteError => e
        raise ::Spaces::Errors::ImportFail, e.message
      end

      def pull_remote
        opened.pull(:origin, branch_name)
      rescue ::Git::GitExecuteError => e
        raise ::Spaces::Errors::ImportFail, e.message
      end

      def opened
        @opened ||= git.open(space.path_for(descriptor), log: logger)
      end

      def git; ::Git ;end

      def initialize(descriptor, space:)
        self.descriptor = descriptor
        self.space = space
      end

    end
  end
end
