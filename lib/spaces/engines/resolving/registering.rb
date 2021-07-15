module Resolving
  module Registering

    def registered
      connect_bindings.map do |c|
        empty_entry.tap do |m|
          m.struct = OpenStruct.new.tap do |s|
            s.resolution_identifier = identifier
            s.bindings = [c.struct]
          end
        end
      end
    end

    def registerable?
      @registerable ||= connect_bindings.any?
    end

    def empty_entry; entry_class.new ;end
    def entry_class; ::Registry::Entry ;end

  end
end
