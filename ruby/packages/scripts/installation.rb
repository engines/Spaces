require_relative '../../texts/script'

module Packages
  module Scripts
    class Installation < Texts::Script

      def body
      [
        downloading,
        (extracting unless git?),
        placing
      ]
      end

      def downloading
        git? ? downloading_with_git : downloading_with_wget
      end

      def downloading_with_git
        "git clone #{options} --depth 1 -b #{branch} #{repository} #{extracted_path}"
      end

      def downloading_with_wget
        "wget #{options} -O #{identifier} #{repository}"
      end

      def extracting
        %Q(
  			#{extraction} #{identifier}
        )
      end

      def placing
        %Q(
        if test ! -d "./#{extracted_path}"
        then
          mkdir -p "#{destination_path}"
        fi

        if test -d "#{destination_path}"
        then
          if test -f  ./"#{extracted_path}"
          then
            cp -rp "./#{extracted_path}" #{destination_path}
          else
        		cp -rp "./#{extracted_path}/." #{destination_path}
        	fi
        else
          if ! test -d #{directory_name}
          then
         	  mkdir -p #{directory_name}
          fi
        	mv "./#{extracted_path}" #{destination_path}
        fi

        if test -f /#{installation_path}/#{extracted_path}
        then
        	rm -rf /#{installation_path}/#{extracted_path}
        fi
        )
      end

      delegate(
        descriptor: :context,
        [:identifier, :branch, :repository, :extraction, :extracted_path, :destination_path, :git? ] => :descriptor
      )

      def directory_name
        File.dirname(destination_path)
      end

      def options
      end

    end
  end
end
