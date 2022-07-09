require_relative 'model'

module Spaces
  class Descriptor < Model

    class << self
      def features = [:identifier, :repository, :remote, :branch, :protocol]
    end

    def identifier = struct.identifier || derived_features[:identifier]

    def repository = struct.repository
    def remote = struct.remote || derived_features[:remote]
    def branch = struct.branch || derived_features[:branch]
    def protocol = struct.protocol || derived_features[:protocol]
    def git? = protocol == 'git'

    alias_method :repository_url, :repository
    alias_method :remote_name, :remote
    alias_method :branch_name, :branch

    def pathname = (Pathname.new(repository) if repository)

    def initialize(args)
      self.struct = args[:struct] || OpenStruct.new(args)
    end

    def to_s = [repository_url, branch, identifier].compact.join(' ')

    protected

    def derived_features
      @derived_features ||= {
        identifier: root_identifier,
        remote: 'origin',
        branch: 'main',
        protocol: default_protocol
      }
    end

    def root_identifier = "#{basename}"&.split('.')&.first

    def default_protocol = extname.blank? ? 'git' : extname.gsub('.', '')

    def basename = pathname&.basename
    def extname = pathname&.extname

  end
end
