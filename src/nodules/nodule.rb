require_relative '../emitting/emissions/subdivision'

module Nodules
  class Nodule < ::Emitting::Subdivision

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
