require_relative 'pack'
require_relative 'file_paths'

module Adapters
  class FilePacking < Pack
    include Keyed
    include FilePaths

      def adapter_keys
        precedence
      end

      def directories
        @directories ||=
          resolutions.path_for(pack).children.select do |c|
            c.directory? && auxiliary_directories.include?(:"#{c.basename}")
          end
      end

  end
end
