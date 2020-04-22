require './ruby/projects/blueprint'
require './ruby/projects/controller'
require './ruby/universal/space'

module Projects
  class Controller

    def initialize(params)
      @params = params
    end

    attr_reader :params

    def index
      u = ::Universal::Space.new
      u.projects.identifiers.sort
    end

    def create(attributes)
      u = Universal::Space.new
      d = Spaces::Descriptor.new(attributes)
      b = Blueprint.new(descriptor: d)
      u.projects.save(b)
    end

    def show(identifier)
      u = Universal::Space.new
      d = Spaces::Descriptor.new({identifier: identifier})
      Blueprint.new(descriptor: d)
    end

  end
end
