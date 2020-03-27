require_relative '../installations/subdivision'

module Nodules
  class Nodule < ::Installations::Subdivision

    class << self
      def qualifier
        name.split('::').last.downcase
      end

      def script_lot
        @@nodule_script_lot ||= [:installation]
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
