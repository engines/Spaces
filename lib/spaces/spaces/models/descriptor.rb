require_relative 'model'

module Spaces
  class Descriptor < Model

    class << self
      def features; [:identifier, :repository, :remote, :branch, :protocol] ;end
    end

    delegate([:basename, :extname] => :pathname)

    def identifier; struct.identifier || derived_features[:identifier] ;end

    def repository; struct.repository ;end
    def remote; struct.remote || derived_features[:remote] ;end
    def branch; struct.branch || derived_features[:branch] ;end
    def protocol; struct.protocol || derived_features[:protocol] ;end
    def git?; protocol == 'git' ;end

    alias_method :repository_url, :repository
    alias_method :remote_name, :remote
    alias_method :branch_name, :branch

    def pathname
      Pathname.new(repository_url)
    end

    def initialize(args)
      if args[:struct]
        self.struct = args[:struct]
        if args[:identifier]
          self.struct.identifier = args[:identifier]
        end
      else
         self.struct = OpenStruct.new(args)
       end
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

    def root_identifier; "#{basename}".split('.')&.first ;end

    def default_protocol
      extname.blank? ? 'git' : extname.gsub('.', '')
    end

  end
end
