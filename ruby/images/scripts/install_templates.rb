require_relative '../../texts/one_time_script'

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
        install_template()
              {
              dest_file=`echo $file | sed "/^.*application_files\//s///"`
              dest_dir=`dirname $dest_file`
              mkdir -p $dest_dir
                 # If soft link copy to destination
               if test -h $dest_file
                then
                  dest_file=`ls -l $dest_file |cut -f2 -d">"`
                fi
               echo Install template $dest_file
               cp $file $dest_file
              }

        cd /home
         if test -d /home/engines/application_files/
          then
           templates=`find /home/engines/application_files/ -type f |grep -v keep_me`
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
