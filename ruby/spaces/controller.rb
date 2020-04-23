require './ruby/spaces/controller'
require './ruby/universal/space'
require './ruby/lib/string'

module Spaces
  class Controller

    def initialize(params)
      @params = params
    end

    def index
      space.identifiers.sort
    end

    def show
      space.by(descriptor_for({identifier: params[:id]}))
    end

    def create
      d = descriptor_for(params[:blueprint])
      space.save(
        member.new(descriptor: d)
      )
      d.identifier
    end

    def delete
      space.delete(
        space.by(descriptor_for({identifier: params[:id]}))
      )
      true
    end

    private

    attr_reader :params

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

    def member
      Object.const_get("#{space_class}::#{member_class}")
    end

    def descriptor_for(attributes)
      Spaces::Descriptor.new(attributes)
    end

  end
end
