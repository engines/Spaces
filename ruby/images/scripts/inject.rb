require_relative '../../texts/one_time_script'

module Images
  module Scripts
    class Inject < Texts::OneTimeScript
      def body
        #Notes for future improvements
        #find /home/engines/templates/ and the following for can be replaced with a list of template files using the following format
        # file=#{template_file}  note file is the path relative to #{home_app_path}
        # install_template
        #
        # function will need some minor changes to support replacing the sed line ...
        %Q(
        inject()
              {      
             # dest_file=`echo $file | sed "/^.*injections\/home\//s///"`
               echo dest_file = $dest_file
              dest_dir=`dirname $dest_file`
        echo mkdir -p $dest_dir
              mkdir -p $dest_dir
                 # If soft link copy to destination
               if test -h $dest_file
                then
                  dest_file=`ls -l $dest_file |cut -f2 -d">"`
                fi
               echo Install template /home/app/$dest_file
               cp $file /home/app/$dest_file
              }

        cd /home
         if test -d /home/engines/injections/home/app
          then
           cd /home/engines/injections/home/app
           templates=`find . -type f |grep -v keep_me`
            for file in $templates
              do
        dest_file=$file
               inject
              done
         fi
        )
      end

    end
  end
end
