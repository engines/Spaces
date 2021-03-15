module Emissions
  module Inflating

    def inflated
      empty.tap do |m|
        m.predecessor = self

        m.struct = OpenStruct.new.tap do |s|
          s.identifier = identifier

          division_keys.each { |k| s[k] = send(k).inflated.struct }
        end
      end
    end

  end
end
