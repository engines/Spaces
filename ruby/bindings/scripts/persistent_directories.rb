require_relative '../../texts/one_time_script'

module Bindings
  module Scripts
    class PersistentDirectories < Texts::OneTimeScript
      def body
        #FIXME /home/fs/vol_dir_maps and /home/volumes/$volume are also used by fsconfigurator (static scripts in a static image) so may need to write these files
        r = ". ./persistent_functions.sh"
        r += write_files
        r += write_directories
        r
      end

      def write_files
        r= ' '
        context.persistent(:files).each do |p|
          r += "Pfiles #{p}"
#          r += %Q(
#                 dest_path=#{context}
#                 ln_destination=#{context.path}/#{p.path}
#                 destination=/home/fs/$dir/#{p.path}
#                 dir_abs_path=#{abs_path(context)}
#                 setup_persistent_dir
#                 )
        end
        r
      end

      def write_directories
        r= ' '
        context.persistent(:directories).each do |p|
          r += "Pdirectories #{p}"
          
#          r += %Q(
#                     dest_path=#{context}
#                     ln_destination=#{b.path}/#{p.path}
#                     destination=/home/fs/$dir/#{p.path}
#                     dir_abs_path=#{abs_path(context)}
#                     setup_persistent_dir
#                     )
        end
        r
      end

      def abs_path(p)
        p
        #FIXME apply logic from shell script below
      end

      #      file_abs_path=$file
      #                echo $file | grep ^#{home_app_path}/
      #                if ! test $? -eq 0
      #                 then
      #                  echo $file | grep ^/home/home_dir/
      #                   if ! test $? -eq 0
      #                  then
      #                    echo $file | grep ^/usr/local/
      #                      if ! test $? -eq 0
      #                       then
      #                         file_abs_path=/home/$file
      #                      fi
      #                 fi
      #               fi
      #

    end
  end
end
