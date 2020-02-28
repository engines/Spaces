require_relative '../../../texts/one_time_script'

module Images
  module Scripts
    class PersistentDirs < Texts::OneTimeScript
      def body
        #Notes for future improvements
        #Most can be dynamically generated from persistent dirs in bp.
        #/home/fs/vol_dir_maps and /home/volumes/$volume are also used by fsconfigurator (static scripts in a static image)
        %Q(
        if test -d /home/volumes/
         then
          for dir  in `cat /home/fs/vol_dir_maps | awk '{ print $1}'`
           do
            volume=`grep "$dir " /home/fs/vol_dir_maps| awk '{print $2}'`
            dest_path=`cat /home/volumes/$volume`
            echo Dest Path $dest_path
            ln_destination=$dest_path/$dir
            destination=/home/fs/$dir

            echo $volume maps to $dest_path, for persistent dir $dir

            if ! test -d `dirname $destination`
             then
              echo "creating Destination $destination"
              mkdir -p `dirname $destination`
             fi

             dir_abs_path=$dir

             echo "Resolve path $dir "
             echo $dir/ | grep -e '^#{home_app_path}/'
              if test $? -ne 0
               then
                echo $dir/ | grep ^/home/home_dir/
                 if test $? -ne 0
                 then
                 echo $dir/ | grep ^/usr/local/
                   if test $? -ne 0
                      then
                        dir_abs_path=/home/$dir
                     fi
                fi
             fi
             echo "Resolved path $dir_abs_path"

             if ! test -d $dir_abs_path
              then
               echo "Creating Resolved path $dir_abs_path"
               mkdir -p $dir_abs_path
             fi

             echo "cp -rnp $dir_abs_path $destination "
            cp -rnp $dir_abs_path  $destination
            rm -rf $dir_abs_path
            echo "ln -s $ln_destination $dir_abs_path"
            ln -s $ln_destination $dir_abs_path
          done
        fi
        )
      end

      def identifier
        'persistent_dirs'
      end
    end
  end
end
