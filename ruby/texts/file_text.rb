require_relative 'text'

module Texts
  class FileText < Text

    attr_accessor :source_file_name,
      :source

    def source
      @source ||=
      begin
        f = File.open(source_file_name, 'r')
        f.read
      ensure
        f.close
      end
    end

    def path
      source_file_name
    end

    def file_path
      "#{subspace_path}/#{file_name}"
    end

    def file_name
      source_file_name.split('/').last
    end

    def subspace_path
      "#{context.subspace_path}/home/engines/#{directory_structure_path}"
    end

    def directory_structure_path
      source_file_name.gsub(/.*?(?=custom_files)/im, '').split('/')[0 .. -2].join('/')
    end

    def initialize(source_file_name:, context:)
      self.context = context
      self.source_file_name = source_file_name
    end

  end
end
