module Interpolating
  module Iterating

    def resolvable?
      working_value != once
    end

    def completed
      @completed ||= complete? ? once : again
    end

    def complete?
      (!once.include?(interpolation_marker))
    rescue NoMethodError => e
      true
    end

    def once
      @once ||= iteration
    end

    def again
      klass.new(original_value: original_value, text: text, last_iteration: once.gsub(interpolation_marker, '')).resolved
    end

  end
end
