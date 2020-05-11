require_relative '../../docker/files/step'

module Starters
  module Steps
    class From < Docker::Files::Step

      delegate([:identifier, :tag] => :context)

      def instructions
        ['FROM', platform, image, 'AS', identifier].compact.join(' ')
      end

      def platform
        if p = context.platform; "--platform=#{p}" ;end
      end

      def image
        [context.image, tag].compact.join(':')
      end

    end
  end
end
