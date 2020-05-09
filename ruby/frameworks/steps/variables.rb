require_relative 'requires'

module Frameworks
  module Steps
    class Variables < Docker::Files::Step

      def instructions
        %Q(
        ENV CONTFSVolHome /home/fs/
        ENV ContUser '#{context.user_name}'
        ENV FRAMEWORK '#{context.klass.identifier}'
        ENV RUNTIME '#{context.klass.identifier}'
        ENV PORT '#{context.port}'
        )
      end

    end
  end
end
