require_relative 'translating'
require_relative 'interfacing'

module Providers
  class Provider < ::Spaces::Model
    include Translating
    include Interfacing

    class << self
      alias_method :application_qualifiers, :subqualifiers
    end

    delegate(arenas: :universe)

    def used_in_arena? = arenas_used_in.any?

    def arenas_used_in
      arenas.all.select do |a|
        a.provider_identifiers.include?(identifier.to_sym)
      end
    end

    def name = identifier

    def identifier = struct[:identifier]
    def compute_qualifier = struct[:compute_qualifier]

    def dynamic_type = class_for(class_elements).new(struct: struct)

    def class_elements = [namespace, 2.times.map{struct.qualifier}].flatten

    def initialize(struct: nil, identifiable: nil)
      super(struct: struct)
      self.struct.identifier = identifiable.identifier if identifiable
    end

  end
end
