require_relative 'artifact'

module Artifacts
  class Stanza < Artifact

    alias_method :artifact, :holder

    def resource_type_map = ResourceTypeMap.new.type_map

    def snippets = format.content

    # def format
    #   #TODO: need dynamic type processing
    #   @format ||= Format.new(self)
    # end

    def method_missing(m, *args, &block)
      return artifact.send(m, *args, &block) if artifact.respond_to?(m)
      super
    end

    def respond_to_missing?(m, *)
      artifact.respond_to?(m) || super
    end

  end
end
