require './ruby/installations/installation'
require './ruby/installations/controller'
require './ruby/universal/space'

module Installations
  class Controller

    def index
      u = ::Universal::Space.new
      u.installations.identifiers.sort
    end

    # TODO: define other actions
    #
    # def create(attributes)
    #   u = Universal::Space.new
    #   d = Spaces::Descriptor.new(attributes)
    #   b = Installation.new(descriptor: d)
    #   u.installations.save(b)
    # end
    #
    # def show(identifier)
    #   u = Universal::Space.new
    #   d = Spaces::Descriptor.new({identifier: identifier})
    #   Installation.new(descriptor: d)
    # end
    #
    # etc

  end
end
