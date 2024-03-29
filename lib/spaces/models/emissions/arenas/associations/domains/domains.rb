require_relative 'exotica'

module Associations
  class Domains < ::Divisions::Divisible
    include Exotica

    def all_with_primary_first = [primary, all].flatten.uniq(&:identifier)

    def primary = map.first

  end
end
