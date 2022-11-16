module Adapters
  module CodeArtifact
    class Repository < ::Adapters::Repository

      delegate(
        struct: :division,
        [:domain, :name] => :struct,
        [:account_identifier, :region] => :compute_provider
      )

      def access
        system_execute(
          configure_global_index_url(
            system_execute(get_authorization_token).first.chop
          )
        )
      end

      def configure_global_index_url(token)
        #FIX: assumes the repository contains python! will need to delegate to a Providers::Python object
        %(XDG_CONFIG_HOME=/tmp pip3 config set global.index-url https://aws:#{token}@#{domain}-#{account_identifier}.d.codeartifact.#{region}.amazonaws.com/pypi/#{name}/simple/)
      end

      def get_authorization_token
        %(aws codeartifact get-authorization-token --domain #{domain} --domain-owner #{account_identifier} --region #{region} --query authorizationToken --output text --duration-seconds 900)
      end

      def compute_provider =
        @computer_provider ||= arena.compute_provider_for_role(:packing)

    end
  end
end
