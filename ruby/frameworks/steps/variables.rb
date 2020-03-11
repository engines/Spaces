require_relative 'requires'

module Frameworks
  module Steps
    class Variables < Docker::Files::Step

      def product
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
