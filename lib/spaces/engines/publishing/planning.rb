module Publishing
  module Planning

    def planned
      empty_plan.tap do |m|
        m.struct = OpenStruct.new.tap do |s|
          s.identifier = identifier
          m.division_keys.each { |k| s[k] = send(k).struct }
        end
      end
    end

    def plannable?
      @plannable ||= bindings.any?
    end

    def empty_plan; plan_class.new ;end
    def plan_class; ::Planning::Plan ;end

  end
end
