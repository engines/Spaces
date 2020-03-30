require_relative '../../texts/one_time_script'

module Bindings
  module Scripts
    class PersistentFunctions < Texts::OneTimeScript
      def body
        #Notes for future improvements
        #Most can be dynamically generated from persistent dirs in bp.
        #/home/fs/vol_dir_maps and /home/volumes/$volume are also used by fsconfigurator (static scripts in a static image)
        %Q(
        
        setup_persistent_file()
        {
        if ! test -d `dirname $destination`
         then
         echo "mkdir -p $destination"
           mkdir -p `dirname $destination`
         fi
          
         if ! test -f $file_abs_path
          then
           touch $file_abs_path
         fi
         echo cp -np $file_abs_path $destination
       cp -np $file_abs_path $destination
       rm $file_abs_path
       echo "ln -s $ln_destination $file_abs_path"
       ln -s $ln_destination $file_abs_path
        }
        
        setup_persistent_dir()
        {
            if ! test -d `dirname $destination`
             then
              echo "creating Destination $destination"
              mkdir -p `dirname $destination`
             fi

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
        })
      end
    end
  end
end
