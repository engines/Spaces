require_relative '../../texts/one_time_script'

module Bindings
  module Scripts
    class Persistence <  Texts::OneTimeScript
      def body
        #FIXME /home/fs/vol_dir_maps and /home/volumes/$volume are also used by fsconfigurator (static scripts in a static image) so may need to write these files
        [
          ". #{script_path}/persistent_functions.sh",
          write(:files),
          write(:directories)
        ].join("\n")
      end

      def script_path
        subpath.sub(/^[a-zA-Z]*\//, '/')
      end

      def write(symbol)
        context.persistent(symbol).map do |k, v|
          p = binding_for(k).path
          v.map do |f|
            %Q(
            mkdir -p #{p}
            ln_destination=#{p}/#{f}
            destination=#{p}
            abs_path=#{abs_path(f)}
            #{function_for(symbol)}\n\n
            )
          end
        end
      end

      def function_for(symbol)
        "setup_#{symbol}"
      end

      def binding_for(key)
        context.send(key)
      end

      def abs_path(p)
        local?(p) ? p : "/home/#{p}"
      end

      def local?(p)
        p.start_with?('/home/') || p.start_with?('/usr/local/')
      end

    end
  end
end
