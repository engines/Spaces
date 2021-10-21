require_relative 'model'

module Spaces
  class Descriptor < Model

    class << self
      def features; [:identifier, :repository, :remote, :branch, :protocol] ;end
    end

    def identifier; struct.identifier || derived_features[:identifier] ;end

    def repository; struct.repository ;end
    def remote; struct.remote || derived_features[:remote] ;end
    def branch; struct.branch || derived_features[:branch] ;end
    def protocol; struct.protocol || derived_features[:protocol] ;end
    def git?; protocol == 'git' ;end

    alias_method :repository_url, :repository
    alias_method :remote_name, :remote
    alias_method :branch_name, :branch

    def pathname; Pathname.new(repository) if repository ;end

    def initialize(args)
      self.struct = args[:struct] || OpenStruct.new(args)
    end

    def to_s
      [repository_url, branch, identifier].compact.join(' ')
    end

    protected

    def derived_features
      @derived_features ||= {
        identifier: root_identifier,
        remote: 'origin',
        branch: 'main',
        protocol: default_protocol
      }
    end

    def root_identifier; "#{basename}"&.split('.')&.first ;end

    def default_protocol
      extname.blank? ? 'git' : extname.gsub('.', '')
    end

    def basename; pathname&.basename ;end
    def extname; pathname&.extname ;end

  end
end
