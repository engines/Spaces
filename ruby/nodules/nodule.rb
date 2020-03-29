require_relative '../installations/subdivision'

module Nodules
  class Nodule < ::Installations::Subdivision

    class << self
      def qualifier
        name.split('::').last.downcase
      end
    end

    def build_script_path
      "#{super}/#{type}"
    end

    def identifier
      name
    end

  end
end
