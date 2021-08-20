require 'git'
require_relative 'importing'
require_relative 'exporting'

module Spaces
  module Git
    class Repository < ::Spaces::Model
      include Engines::Logger
      include Importing
      include Exporting

      relation_accessor :descriptor
      relation_accessor :space

      delegate(
        [:repository_url, :identifier, :branch_name, :remote_name, :protocol] => :descriptor
      )

      def branch_names_without_head
        opened.branches.map(&:name).uniq.reject { |b| b.include?(head_identifier) }
      end

      alias_method :branch_names, :branch_names_without_head

      def diff
        opened.diff.patch
      end

      def checkout
        opened.branch(branch_name).checkout
      end

      def add_remote
        opened.add_remote(remote_name, repository_url).tap { fetch }
      end

      def fetch
        opened.fetch(remote_name)
      end

      def remote_url
        opened.remote(remote_name).url
      end

      def opened(&block)
        @opened ||= (
          init unless exist?
          git.open(space.path_for(descriptor), log: logger).tap { yield if block_given? }
        )
      end

      def exist?
        space.path_for(descriptor).join(".#{protocol}").exist?
      end

      def raise_failure_for(exception)
        raise failure, {message: exception.message}
      end

      def git; ::Git ;end
      def git_error; ::Git::GitExecuteError ;end
      def failure; ::Spaces::Errors::RepositoryFail ;end
      def head_identifier; 'HEAD ->' ;end

      def initialize(descriptor, space:)
        self.descriptor = descriptor
        self.space = space
      end

      protected

      def init
        git.init("#{space.path_for(descriptor)}", log: logger).tap do
          add_remote
        end
      end

    end
  end
end
