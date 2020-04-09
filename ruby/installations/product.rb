require_relative '../spaces/model'
require_relative '../images/product'
require_relative '../docker/files/product'

module Installations
  class Product < ::Spaces::Model
    include Images::Product
    include Docker::Files::Product

    class << self
      def step_precedence
        { anywhere: files_in(:steps).map { |f| File.basename(f, '.rb') } }
      end

      def script_lot
        files_in(:scripts).map { |f| File.basename(f, '.rb') }
      end

      def require_files_in(*folders)
        [*folders].each { |f| files_in(f).each { |f| require f } }
      end

      def files_in(folder)
        [inheritance_paths].flatten.map { |h| Dir["#{h}/#{folder}/*"] }.flatten
      end

      def inheritance_paths; end
    end

    def path
      "build/#{super}"
    end

    alias_method :collaborator_path, :path

    def product
      duplicate(struct)
    end

  end
end
