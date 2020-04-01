require_relative '../../texts/one_time_script'

module Bindings
  module Scripts
    class PersistentDirectories <  Texts::OneTimeScript
      def body
        #FIXME /home/fs/vol_dir_maps and /home/volumes/$volume are also used by fsconfigurator (static scripts in a static image) so may need to write these files
        r = ". ./persistent_functions.sh\n"
        #Following commented while working out why scrip not written
#        r += write_cmds('setup_persistent_file')
#        r += write_cmds('setup_persistent_dir')
        r
      end

      def write_cmds(c)
        r= ' '
        context.persistent(:files).each do |p|
          d = context.send(p[0]).path
          p[1].each do |f|
            r += %Q(
                           dest_path=#{d}
                           ln_destination=#{d}/#{f}
                           destination=/home/fs/#{d}/#{f}
                           dir_abs_path=#{abs_path(f)}
                           #{c}\n\n                 
                           ) 
          end
        end
        r
      end

      def abs_path(p)
   #     p = "/home/#{p}" unless p.starts_with('/home/') || p.starts_with('/usr/local/') 
        p 
      end

    end
  end
end
