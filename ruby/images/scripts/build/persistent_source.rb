require_relative '../../../products/script'

module Images
  module Scripts
    class PersistentSource < Products::Script
      def body

        %Q(
        if test -d  /home/volumes
         then
          mv /home/volumes /home/fs
        fi
        
        if test -d /home/fs
         then 
          mv /home/fs /home/fs_src
          else
            mkdir /home/fs_src
        fi
        )
      end

      def identifier
        'persistent_source'
      end
    end
  end
end
