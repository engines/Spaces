require_relative 'model'

module Spaces
  class Descriptor < Model

    class << self
      def features = [:identifier, :repository, :remote, :branch, :protocol]
    end

    def with_account(account)
      klass.new(struct: struct.merge(account: account))
    end

    def identifier = struct.identifier || derived_features[:identifier]

    def remote = struct.remote || derived_features[:remote]
    def branch = struct.branch || derived_features[:branch]
    def protocol = struct.protocol || derived_features[:protocol]

    def account = struct.account || derived_account
    def repository = struct.repository || derived_repository

    def has_derivable_repository? = struct.account && struct.identifier

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

    def derived_account
      struct.repository&.split("/#{identifier}")&.first
    end

    def derived_repository
      [account, identifier].join('/') if has_derivable_repository?
    end

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
