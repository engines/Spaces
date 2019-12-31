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
    
    def encloses?(descriptor)
      route(:encloses?, descriptor)
    end

    def by(descriptor)
      route(:by, descriptor)
    end

    def import(descriptor)
      route(:import, descriptor)
    end

    def route(method, descriptor)
      maps[:"#{descriptor.extension}"].send(method, descriptor)
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

  end
end
