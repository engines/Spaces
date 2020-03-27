require_relative '../installations/subdivision'

module Packages
  class Package < ::Installations::Subdivision

    Dir["#{__dir__}/scripts/*"].each { |f| require f }

    class << self
      def script_lot
        @@package_script_lot ||= [:preparation, :installation]
      end
    end

    def subspace_path
      context.subspace_path
    end

    def build_script_path
       context.build_script_path
    end

  end
end
