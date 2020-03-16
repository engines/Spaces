require_relative '../../../texts/script'

module Images
  module Scripts
    class InstallTemplates < Texts::OneTimeScript
      def body
        #Notes for future improvements
        #find /home/engines/templates/ and the following for can be replaced with a list of template files using the following format
        # file=#{template_file}  note file is the path relative to #{home_app_path}
        # install_template
        #
        # function will need some minor changes to support replacing the sed line ...
        %Q(
        . #{build_script_path}/build_functions.sh

        cd /home
         if test -d /home/engines/templates/
          then
           templates=`find /home/engines/templates/ -type f |grep -v keep_me`
            for file in $templates
              do
               install_template
              done
         fi
        )
      end

    end
  end
end
