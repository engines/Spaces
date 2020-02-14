require_relative '../../../collaborators/script'

module Frameworks
  module ApachePHP
    module Scripts
      class Installation < Collaborators::Script

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

        def identifier
          'installation'
        end

      end
    end
  end
end
