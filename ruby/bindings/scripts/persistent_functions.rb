require_relative '../../texts/one_time_script'

module Bindings
  module Scripts
    class PersistentFunctions < Texts::OneTimeScript

      def body
      #Notes for future improvements
      #Most can be dynamically generated from persistent dirs in bp.
      #/home/fs/vol_dir_maps and /home/volumes/$volume are also used by fsconfigurator (static scripts in a static image)
      %Q(
      setup_files() {
        #{ensure_directory_exists}

        if ! test -f $abs_path
        then
          touch $abs_path
        fi

        #{echo 'cp -np $abs_path $destination'}

        rm $abs_path

        #{echo 'ln -s $ln_destination $abs_path'}
      }

      setup_directories() {
        #{ensure_directory_exists}

        if ! test -d `dirname $destination`
        then
          #{echo 'mkdir -p `dirname $destination`'}
        fi

        if ! test -d $abs_path
        then
          #{echo 'mkdir -p $abs_path'}
        fi

        #{echo 'cp -rnp $abs_path $destination'}

        rm -rf $abs_path

        #{echo 'ln -s $ln_destination $abs_path'}
      })
      end

      def ensure_directory_exists
      %Q(
      if ! test -d `dirname $destination`
      then
        #{echo 'mkdir -p `dirname $destination`'}
      fi
      )
      end

    end
  end
end
