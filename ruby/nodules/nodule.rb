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

      def step_precedence
        @@nodule_step_precedence ||= {}
      end
    end

    def build_script_path
      "#{context.build_script_path}/#{type}"
    end

    def identifier
      name
    end

  end
end
