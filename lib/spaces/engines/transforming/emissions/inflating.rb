module Emissions
  module Inflating

    def inflated; flated(:inflated) ;end
    def deflated; flated(:deflated) ;end

    def flated(desired_state)
      empty.tap do |m|
        m.predecessor = self

        m.struct = OpenStruct.new.tap do |s|
          s.identifier = identifier if desired_state == :inflated

          division_keys.each { |k| s[k] = send(k).send(desired_state).struct }
        end
      end
    end

  end
end
