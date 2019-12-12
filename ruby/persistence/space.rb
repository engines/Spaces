require_relative '../framework/space'
require_relative 'git/space'
require_relative 'uri/space'

module Persistence
  class Space < ::Framework::Space
    # The dimensions in which long-lived recordings of software objects can be made and maintained.

    class << self
      def git
        @@git ||= Persistence::Git::Space.new
      end

      def uri
        @@uri ||= Persistence::Uri::Space.new
      end
    end

    def_delegator self, :git
    def_delegator self, :uri    

  end
end
