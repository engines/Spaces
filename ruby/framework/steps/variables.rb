require_relative 'requires'

module Framework
  class Framework
    class Variables < Container::Docker::Step

      def content
        %Q(
          ENV CONTFSVolHome /home/fs/
          ENV FRAMEWORK '#{context.identifier}'
          ENV RUNTIME '#{context.identifier}'
          ENV PORT '#{context.port}'
        )
      end

    end
  end
end
