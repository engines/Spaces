require_relative 'artifact'

module Artifacts
  module Terraform
    module Aws
      class Capsule < ::Artifacts::Terraform::Capsule

        def stanza_qualifiers; [:capsule] ;end

        # def capsule_type
        #   [runtime_qualifier, 'container'].compact.join('_')
        # end

      end
    end
  end
end
