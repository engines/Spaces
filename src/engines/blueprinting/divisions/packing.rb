module Divisions
  class Packing < ::Emissions::Division
    include ::Packing::Division

    class << self
      def script_choices(precedence)
        Pathname(__dir__).join('scripts', precedence).children
      end

      def script_choices_names(precedence)
        script_choices(precedence).map(&:basename_as_sym)
      end

      def precedence_choices
        Pathname(__dir__).join('scripts').children.map(&:basename_as_sym)
      end
    end

    def packing_stanza_for(precedence)
      {
        type: 'shell',
        inline: send(precedence).map do |s|
          temporary_script_path.join("#{precedence}", s)
        end
      }
    end

    def temporary_script_path
      Pathname('tmp').join('packing','scripts')
    end

    def basename_as_sym(p)
      p.basename.to_s.to_sym
    end

  end
end
