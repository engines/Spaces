require 'git'
require_relative 'ssh'

module Spaces
  module Git
    class Space < ::Spaces::Space
      include Ssh

      delegate(locations: :universe)

      def by_import(descriptor, force:)
        repository_for(descriptor).by_import(force: force)
      end

      def export(descriptor, **args, &block)
        repository_for(descriptor).export(**args, &block)
      end

      def repository_for(descriptor)
        repository_class.new(location_maybe_already_set_for(descriptor), space: self)
      end

      def location_maybe_already_set_for(descriptor)
        locations.exist_then_by(descriptor) || descriptor
      end

      def git; ::Git ;end
      def git_error; ::Git::GitExecuteError ;end
      def repository_class; ::Spaces::Git::Repository ;end

      def initialize(*args)
        super.tap do
          write_ssh_command
          configure
        end
      end

      protected

      def configure
        ::Git.configure { |c| c.git_ssh = "#{ssh_command_path}" }
      end

    end
  end
end
