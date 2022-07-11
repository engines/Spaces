require_relative 'pack'

module Adapters
  class FilePacking < Pack
    include Keyed

      def adapter_keys = precedence

      def directories
        @directories ||=
          resolutions.path_for(pack).children.select do |c|
            c.directory? && auxiliary_directories.include?(:"#{c.basename}")
          end
      end

  end
end
