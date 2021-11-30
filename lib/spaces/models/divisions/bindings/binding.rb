require 'resolv'
require_relative 'publishing'
require_relative 'packing'

module Divisions
  class Binding < ::Targeting::Binding
    include ::Divisions::Binding::Publishing # NOW WHAT?
    include ::Divisions::Binding::Packing # NOW WHAT?

    delegate(
      [:locations, :blueprints, :installations, :resolutions] => :universe,
      binder?: :blueprint # NOW WHAT?
    )

    def arena
      emission.arena if emission.respond_to?(:arena)
    end

    def context_identifier
      [arena&.identifier&.with_identifier_separator, target_identifier].join
    end

    def blueprint; @blueprint ||= target_from(blueprints) ;end

    def installation; @installation ||= target_from(installations) ;end
    def resolution; @resolution ||= target_from(resolutions) ;end

  end
end
