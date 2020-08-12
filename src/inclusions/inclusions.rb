require_relative '../releases/division'
require_relative 'inclusion'

module Inclusions
  class Inclusions < ::Releases::Division

    def squashed
      resolutions.reduce({}) do |m, r|
        h = r.to_h
        h.keys.each do |k|
          pp '-' * 11
          pp k
          m[k] = (m[k] || {}).merge(h[k])
        end
        m
      end
    end

    def resolutions
      @resolutions ||= all.map(&:resolution)
    end

  end
end
