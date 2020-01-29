require_relative 'requires'

class Software
  class Packages < Docker::File::Step

    def content
      "ADD /home/app /home"
    end

  end
end
