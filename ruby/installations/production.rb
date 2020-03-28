require_relative '../spaces/model'
require_relative '../images/production'
require_relative '../docker/files/production'

module Installations
  class Production < ::Spaces::Model
    include Images::Production
    include Docker::Files::Production

    class << self
      def step_precedence; end

      def script_lot
        files_in(:scripts).map { |f| File.basename(f, '.rb') }
      end

      def require_files_in(folder)
        files_in(folder).each { |f| require f }
      end

      def files_in(folder)
        Dir["#{here}/#{folder}/*"]
      end

      def here; end
    end

    def product
      duplicate(struct)
    end

  end
end
