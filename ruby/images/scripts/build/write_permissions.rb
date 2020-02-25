require_relative '../../../texts/script_once'

module Images
  module Scripts
    class WritePermissions < Texts::ScriptOnce
      def body
        #Notes for future improvements
        #
        #for each file to permission #remove ^../ and /../ from string
        #also strip any proceeding #{home_app_path} and remove any trailing /
        # then for each file_to_permission
        #Paths referenced are static but global
        %Q(
        . #{framework_build_script_path}/build_functions.sh

        for path in $*
         do
          set_path_permission
        done
        )
      end

    end
  end
end
