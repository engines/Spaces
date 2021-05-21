module Divisions
  class Nodules < ::Divisions::Division
    include ::Packing::Division

    class << self
      def subdivision_class; NoduleArray ;end
    end

    delegate(subdivision_class: :klass)

    def all
      @all ||= keys.map { |k| subdivision_for(k) }.compact
    end

    def subdivision_for(key)
      subdivision_class.prototype(type: key, struct: struct[key], division: self)
    end

    # PACKER-SPECIFIC
    def packing_artifact_for(key)
      {
        type: 'shell',
        inline: send(key).inline
      }
    end

    def method_missing(m, *args, &block)
      all.detect { |a| a.identifier == m.to_s }
    end

    def respond_to_missing?(m, *)
      keys.include?(m)
    end

  end
end
