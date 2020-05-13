require_relative '../releases/subdivision'

module Nodules
  class Nodule < ::Releases::Subdivision

    class << self
      def qualifier
        name.split('::').last.downcase
      end
    end

    def path
      "#{super}/#{type}"
    end

    def identifier
      name
    end

  end
end
