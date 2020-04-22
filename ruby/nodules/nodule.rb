require_relative '../collaborators/subdivision'

module Nodules
  class Nodule < ::Collaborators::Subdivision

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
