require_relative '../../texts/one_time_script'

module Bindings
  module Scripts
    class PersistentDirectories < Texts::OneTimeScript
      def body
        #Notes for future improvements
        #Most can be dynamically generated from persistent dirs in bp.
        #/home/fs/vol_dir_maps and /home/volumes/$volume are also used by fsconfigurator (static scripts in a static image)
        
      r = ". ./persistent_functions.sh"
         context.all.each do |b|
         b.persistent.directories.all.each do |p|
           r += %Q( 
           dest_path=#{b.path}
           ln_destination
                             
         )
            end
           
         end

#        if test -d /home/volumes/
#                then
#                 for dir  in `cat /home/fs/vol_dir_maps | awk '{ print $1}'`
#                  do
#                   volume=`grep "$dir " /home/fs/vol_dir_maps| awk '{print $2}'`
#                   dest_path=`cat /home/volumes/$volume`
#                   echo Dest Path $dest_path
#                   ln_destination=$dest_path/$dir
#                   destination=/home/fs/$dir
#
#                   echo $volume maps to $dest_path, for persistent dir $dir
#                   dir_abs_path=resolve_abs_dir($dir)
#                   setup_persistent_dir
#          done
#         fi

      end
    
    end
  end
end
