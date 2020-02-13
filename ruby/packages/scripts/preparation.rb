require_relative '../../collaborators/script_once'

module Packages
  module Scripts
    class Preparation < Collaborators::ScriptOnce

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
