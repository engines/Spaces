module Artifacts
  module Terraform
    module Aws
      class DnsRecordStanza < ::Artifacts::Aws::DnsRecordStanza

        def more_snippets = DnsRecord::More.new(self).content

      end
    end
  end
end
