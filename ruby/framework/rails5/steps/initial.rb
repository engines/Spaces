require_relative 'requires'

module Framework
  class Rails5
    class Initial < Container::Docker::Step

      def content
        "FROM spaces/ngpassenger:current"
      end

    end
  end
end
