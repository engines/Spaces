require 'resolv'
require_relative 'publishing'
require_relative 'packing'

module Divisions
  class Binding < ::Targeting::Binding
    include ::Divisions::Binding::Publishing
    include ::Divisions::Binding::Packing

    delegate(
      [:locations, :blueprints, :resolutions] => :universe
    )

    def arena
      emission.arena if emission.respond_to?(:arena)
    end

    def context_identifier
      [arena&.identifier&.with_identifier_separator, target_identifier].join
    end

    def binder?; blueprint&.binder? ;end

    def blueprint; @blueprint ||= target_from(blueprints) ;end

    def resolution; @resolution ||= target_from(resolutions) ;end

    alias_method :node, :blueprint

  end
end
