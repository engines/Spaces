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

      def export(**args)
        descriptor.identifier.tap do
          commit(**args)
          push_remote
        end
      end

      def pull_remote
        opened.pull(:origin, branch_name)
      rescue git_error => e
        raise failure, e.message
      end

      def push_remote
        opened.push(:origin, branch_name)
      rescue git_error => e
        raise failure, e.message
      end

      def commit(message: nil)
        opened.commit_all("#{message || default_commit_message} [BY SPACES]")
      rescue git_error => e
        raise failure, e.message
      end

      def opened
        @opened ||= git.open(space.path_for(descriptor), log: logger)
      end

      def default_commit_message; "Exported on #{Time.now}" ;end

      delegate([:repository_name, :identifier, :branch_name] => :descriptor)

      def clone_remote
        git.clone(repository_name, identifier, branch: branch_name, path: space.path, depth: 0)
      rescue git_error => e
        raise fail, e.message
      end

      def git; ::Git ;end
      def git_error; ::Git::GitExecuteError ;end
      def failure; ::Spaces::Errors::RepositoryFail ;end

      def initialize(descriptor, space:)
        self.descriptor = descriptor
        self.space = space
      end

    end
  end
end
