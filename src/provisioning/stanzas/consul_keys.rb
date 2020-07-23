require_relative '../stanza'

module Provisioning
  module Stanzas
    class ConsulKeys < Stanza

      def declaratives
        bindings_with_variables.map do |b|
          %Q(
            resource "consul_key_prefix" "#{identifier_for(b)}" {
              # datacenter = "any"

              path_prefix = "#{path_prefix_for(b)}"

              subkeys = {
                #{subkeys_for(b)}
              }
            }
          )
        end.join("\n")
      end

      def bindings_with_variables; context.bindings.reject { |b| b.variables.to_h.empty? } ;end

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

    end
  end
end
