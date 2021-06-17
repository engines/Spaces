module Publishing
  module Publishing

    def localized; transformed_to(:localized) ; end
    def globalized; transformed_to(:globalized) ; end

    protected

    def transformed_to(method)
      empty.tap do |m|
        m.struct = OpenStruct.new.tap do |s|
          s.identifier = identifier

          division_keys.each { |k| s[k] = send(k).send(method).struct }
        end
      end
    end

  end
end
