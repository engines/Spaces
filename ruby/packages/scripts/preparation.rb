require_relative 'requires'

module Packages
  module Scripts
    class Preparation < Products::Script

      relation_accessor :package

      def body
        %Q(
        mkdir /#{build_script_path}
        cd /#{build_script_path}
        )
      end

    end
  end
end
