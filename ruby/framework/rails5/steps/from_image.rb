require_relative 'requires'

module Framework
  class Rails5
    class FromImage < Docker::File::Step

      def content
        "FROM engines/ngpassenger:current"
      end

    end
  end
end
