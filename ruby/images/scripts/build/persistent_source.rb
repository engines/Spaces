require_relative '../../../collaborators/script_once'

module Images
  module Scripts
    class PersistentSource < Collaborators::ScriptOnce
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
    end
  end
end
