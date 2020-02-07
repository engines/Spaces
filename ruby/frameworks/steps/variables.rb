require_relative 'requires'

module Frameworks
  class Framework
    class Variables < Docker::Files::Step

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
