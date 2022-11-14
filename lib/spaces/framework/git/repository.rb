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
      relation_accessor :stream

      delegate(
        [:repository_url, :identifier, :branch_name, :remote_name, :format] => :descriptor,
        [:git, :git_error] => :space
      )

      def branch_names_without_head =
        opened.branches.map(&:name).uniq.reject { |b| b.include?(head_identifier) }

      alias_method :branch_names, :branch_names_without_head

      def diff = opened.diff.patch

      def add
        opened.add
      end

      def set_branch
        if local_branches.any?
          opened.branch(local_current).move(branch_name)
        else
          create_first_branch
        end
      end

      def create_first_branch
        opened.branch(branch_name).checkout(new_branch: true)
      end

      def local_branches = opened.branches.local

      def local_current = opened.branches.local.find(&:current).name

      def remote_current? = remote_url == repository_url

      def fetch
        opened.fetch(remote_name)
      end

      def remote_url = opened.remote(remote_name).url

      def set_remote
        if opened.remotes.find { |r| r.name == remote_name }
          opened.set_remote_url(remote_name, repository_url)
        else
          add_remote
        end
      end

      def add_remote
        opened.add_remote(remote_name, repository_url)
      end

      def remove_remote
        opened.remote(remote_name).remove
      end

      def opened
        @opened ||= git.open(space.path_for(descriptor))
      end

      def exist? = space.path_for(descriptor).join(".#{format}").exist?

      def collect(io)
        stream&.tap do |s|
          s.output_lines_from(io)
          s.output("\n")
        end
      end

      # TODO: I18N for literal strings "Failed to import" and "Failed to export"
      def maybe_stream_import_error
        stream&.error("Failed to import #{descriptor}\n")
      end

      def maybe_stream_export_error
        stream&.error("Failed to export #{descriptor}\n")
      end

      def clone_failure = ::Spaces::Errors::ImportFailure
      def pull_failure = ::Spaces::Errors::ReimportFailure
      def push_failure = ::Spaces::Errors::ExportFailure
      def head_identifier = 'HEAD ->'

      def initialize(descriptor, space:, stream: nil)
        self.descriptor = descriptor
        self.space = space
        self.stream = stream
        init unless exist?
      end

      def init
        git.init("#{space.path_for(descriptor)}")
      end

      def command_options =
        {
          verbose: true,
          progress: true,
        }

    end
  end
end
