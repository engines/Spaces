require './src/lib/string'
require './src/universal/space'
require './src/spaces/controller/error'

module Spaces
  class Controller

    def initialize(params)
      @params = params
    end

    attr_reader :params

    def index
      space.identifiers.sort
    end

    def show
      space.by(descriptor_for({identifier: params[:id]}))
    end

    def create
      a = params[member_class.snakize]
      raise Error::RequiresIdentifier if a[:identifier].blank?
      d = descriptor_for(a)
      raise Error::AlreadyExists if space.imported?(d)
      space.create(d)
      d.identifier
    end

    def delete
      d = descriptor_for({identifier: params[:id]})
      space.delete(d)
      d.identifier
    end

    private

    def universe
      Universal::Space.new
    end

    def space_class
      self.class.to_s.split('::')[0]
    end

    def member_class
      space_class.singularize
    end

    def space
      universe.send(space_class.snakize)
    end

    def descriptor_for(attributes)
      Spaces::Descriptor.new(attributes)
    end
  end
end
