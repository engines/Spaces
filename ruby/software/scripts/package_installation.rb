require_relative 'requires'

class Software
  class PackageInstallation < Spaces::Script

    relation_accessor :package

    def content
      [
        downloading,
        extracting,
        placing
      ]
    end

    def downloading
      descriptor.protocol == 'git' ? downloading_with_git : downloading_with_wget
    end

    def downloading_with_git
      "git clone #{options} --depth 1 -b #{descriptor.branch} #{descriptor.value} #{descriptor.extracted_path}"
    end

    def downloading_with_wget
      "wget #{options} -O #{descriptor.identifier} #{descriptor.value}"
    end

    def extracting
      %Q(
  			mkdir -p /tmp/#{descriptor.identifier}
  			cd /tmp/#{descriptor.identifier}
  			#{descriptor.extraction} /tmp/#{descriptor.identifier}
  			cd /tmp
      )
    end

    def placing
      %Q(
        mkdir -p "/home/app"

        if test ! -d "./#{descriptor.extracted_path}"
        then
          mkdir -p "#{descriptor.extracted_path}"
        fi

        if test -d "#{descriptor.extracted_path}"
        then
          if test -f  ./"#{descriptor.extracted_path}"
          then
            cp -rp "./#{descriptor.extracted_path}" #{descriptor.identifier}
          else
        		cp -rp "./#{descriptor.extracted_path}/." #{descriptor.identifier}
        	fi
        else
          if ! test -d `dirname #{descriptor.identifier}`
          then
         	  mkdir -p `dirname #{descriptor.identifier}`
          fi
        	mv "./#{descriptor.extracted_path}" #{descriptor.identifier}
        fi

        if test -f /tmp/#{descriptor.extracted_path}
        then
        	rm /tmp/#{descriptor.extracted_path}
        fi

        if test -f tmp/#{descriptor.identifier}
        then
          rm /tmp/#{descriptor.identifier}
        fi
      )
    end

    def descriptor
      package.descriptor
    end

    def options
    end

    def initialize(package)
      self.package = package
    end

  end
end
