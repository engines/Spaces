require_relative '../framework/space'
require_relative 'git/space'
require_relative 'uri/space'
#require_relative '../universal/descriptor'

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

      def maps
        @@maps ||= {
          git: git,
          json: uri
        }
      end
    end

    def git
      self.class.git
    end

    def uri
      self.class.uri
    end

    def maps
      self.class.maps
    end

    def import(descriptor)
      maps[:"#{descriptor.extension}"].send(:import, descriptor)
    end

  end
end
