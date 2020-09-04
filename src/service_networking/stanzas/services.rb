require_relative '../../releases/stanza'

module ServiceNetworking
  module Stanzas
    class Services < ::Releases::Stanza

      def declaratives
        bindings_with_variables.map { |b| q(b) }.join("\n")
      end

      def bindings_with_variables
        collaboration.all(:bindings).reject { |b| b.variables.to_h.empty? }
      end

      def terraform_identifier_for(binding)
        identifier_for(binding).gsub('_', '-')
      end

      def identifier_for(binding)
        "#{binding.collaboration.identifier}_#{binding.identifier}"
      end

    end
  end
end
