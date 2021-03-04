module Emissions
  module Localising

    def localised
      empty.tap do |m|
        m.predecessor = self

        m.struct = OpenStruct.new.tap do |s|
          s.identifier = identifier

          division_keys.each { |k| s[k] = send(k).localised.struct }
        end
      end
    end

  end
end
