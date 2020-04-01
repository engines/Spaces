require_relative '../../texts/one_time_script'

module Bindings
  module Scripts
    class Persistence <  Texts::OneTimeScript
      def body
        #FIXME /home/fs/vol_dir_maps and /home/volumes/$volume are also used by fsconfigurator (static scripts in a static image) so may need to write these files
        r = ". ./persistent_functions.sh\n"
        r += write_cmds('setup_persistent_file')
        r += write_cmds('setup_persistent_dir')
        r
      end

      def write_cmds(c)
        r = ' '
        context.persistent(:files).each do |p|
          d = context.send(p[0]).path
          p[1].each do |f|
            r += %Q(
                           ln_destination=#{d}/#{f}
                           destination=#{d}
                           dir_abs_path=#{abs_path(f)}
                           #{c}\n\n                 
                           ) 
          end
        end
        r
      end

      def abs_path(p)
        p = "/home/#{p}" unless p.start_with?('/home/') || p.start_with?('/usr/local/')
        p 
      end

    end
  end
end
