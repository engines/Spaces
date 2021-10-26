module Adapters
  module Docker
    class FilePacking < ::Adapters::FilePacking

      def snippets_for(precedence)
        directories.select do |d|
          d.children.map(&:basename).map(&:to_s).include?("#{precedence}")
        end.flatten.compact.map do |n|
          "ADD #{n.basename}/#{precedence}/ /"
        end
      end

    end
  end
end
