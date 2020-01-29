require_relative 'requires'
require_relative '../package'

class Software
  class Installation < Spaces::Script

    def content
    end

    def package_class
      Package
    end

  end
end
