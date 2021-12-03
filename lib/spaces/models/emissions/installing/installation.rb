require_relative 'summary'

module Installing
  class Installation < ::Settling::Settlement
    include Installing::Summary

    class << self
      def composition_class; Composition ;end
    end

    delegate(bindings_of_type: :blueprint)

    def division_map
      @division_map ||= super.tap do |d|
        d[:deployment] ||= division_for(:deployment)
      end
    end

  end
end
