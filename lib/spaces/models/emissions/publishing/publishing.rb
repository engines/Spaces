module Publishing
  module Publishing

    def localized = transformed_to(:localized)
    def globalized = transformed_to(:globalized)

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
