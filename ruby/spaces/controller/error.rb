module Spaces
  class Controller

    class Error < StandardError
      class AlreadyExists < Error
        def status; 409 ;end
      end

      class RequiresIdentifier < Error ;end

      def message
        i18n[language][klass] || "#{klass} error."
      end

      def klass
        self.class.to_s.split('::')[-1]
      end

      def language
        'en'
      end

      def i18n
        fp = "#{File.dirname(__FILE__)}/i18n.yaml"
        YAML.load_file(fp)
      end

      def status
        400
      end

    end
  end
end
