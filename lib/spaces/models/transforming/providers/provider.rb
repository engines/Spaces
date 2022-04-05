require_relative 'translating'
require_relative 'interfacing'

module Providers
  class Provider < ::Spaces::Model
    include Translating
    include Interfacing

    class << self
      alias_method :application_qualifiers, :subqualifiers
    end

    def name; identifier ;end

    def identifier; struct[:identifier] ;end

    def prototype
      class_for(class_elements).new(struct: struct)
    end

    def class_elements
      [namespace, 2.times.map{struct.qualifier}].flatten
    end

    def initialize(struct: nil, identifiable: nil)
      super(struct: struct)
      self.struct.identifier = identifiable.identifier if identifiable
    end

  end
end
