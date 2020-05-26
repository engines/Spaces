require_relative 'schema'

module Spaces
  class DescriptorSchema < Schema

    class << self
      def outline
        {
          identifier: 0,
          repository: 0,
          branch: 0,
          protocol: 0,
          extraction: 0,
          extracted_path: 0,
          destination_path: 0,
          key_id: 0,
          key_url: 0,
        }
      end
    end

  end
end
