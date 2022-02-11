require_relative 'exotica'

module Associations
  class Domains < ::Divisions::Divisible
    include Exotica

    def as_owncloud_trusted_names
      all.map do |a|
        "#{all.index(a)} => '#{a.name}'"
      end.join(", ")
    end

  end
end
