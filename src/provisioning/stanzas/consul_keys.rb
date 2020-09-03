require_relative '../../releases/stanza'

module Provisioning
  module Stanzas
    class ConsulKeys < ::Releases::Stanza

      def declaratives
        bindings_with_variables.map { |b| q(b) }.join("\n")
      end

      def q(binding)
        %Q(
          resource "consul_key_prefix" "#{terraform_identifier_for(binding)}" {
            datacenter = "#{data_center.identifier}"

            path_prefix = "#{path_prefix_for(binding)}"

            subkeys = {
              #{subkeys_for(binding)}
            }
          }
        )
      end

      def bindings_with_variables; context.bindings.reject { |b| b.variables.to_h.empty? } ;end

      def terraform_identifier_for(binding)
        identifier_for(binding).gsub('_', '-')
      end

      def identifier_for(binding)
        "#{binding.collaboration.identifier}_#{binding.identifier}"
      end

      def path_prefix_for(binding)
        "#{client_identifier_for(binding)}/#{identifier_for(binding)}/"
      end

      def client_identifier_for(binding)
        binding.collaboration.client.identifier
      end

      def subkeys_for(binding)
        binding.variables.to_h.map { |k, v| %Q("#{k}" = "#{v}") }.join("\n")
      end

      def data_center
        universe.data_centers.default
      end

    end
  end
end
