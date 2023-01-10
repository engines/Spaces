module Adapters
  module CodeArtifact
    class Repository < ::Adapters::Repository

      class << self
        def format_map =
          {
            python: :pypi,
            node: :npm
          }
      end

      delegate(
        format_map: :klass,
        struct: :division,
        [:domain, :name, :content] => :struct,
        [:account_identifier, :region] => :compute_provider
      )

      def compute_provider =
        @computer_provider ||= arena.compute_provider_for_role(:packing)

      def index_url
        "https://aws:#{token}@#{domain}-#{account_identifier}.d.codeartifact.#{region}.amazonaws.com/#{format_map[content]}/#{name}/simple/)"
      end

      def token
        @token ||= system_execute(get_authorization_token).first.chop
      end

      protected

      def get_authorization_token
        %(aws codeartifact get-authorization-token --domain #{domain} --domain-owner #{account_identifier} --region #{region} --query authorizationToken --output text --duration-seconds 900)
      end

    end
  end
end
