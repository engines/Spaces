require_relative 'exotica'

module Associations
  class Domains < ::Divisions::Divisible
    include Exotica

    def all_with_primary_first
      [primary, all].flatten.uniq(&:identifier)
    end

    def primary
      map.detect(&:primary?)
    end

  end
end
