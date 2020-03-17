require_relative '../../../texts/one_time_script'

module Frameworks
  module PHP
    module Scripts
      class Installation < Texts::OneTimeScript

        def body
          %Q(
          cd /home

          if test -d /home/engines/htaccess_files/
           then
          htaccess_files=`find /home/engines/htaccess_files/ -type f |grep -v keep_me`
            for file in $htaccess_files
            	do
               dest_file=`echo $file | sed "/^.*htaccess_files\//s///"`
               dest_dir=`dirname $dest_file`
               mkdir -p app/$dest_dir
                if test -h $dest_file
                 then
                	dest_file=`ls -l $dest_file |cut -f2 -d">"`
                fi
               cp $file app/$dest_file
              done
          fi
          )
        end

      end
    end
  end
end
