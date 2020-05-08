require_relative 'text'

module Texts
  class FileText < Text

    attr_accessor :origin_file_name,
      :directory,
      :origin

    delegate(context_identifier: :context)

    def origin
      @origin ||=
      begin
        f = File.open(origin_file_name, 'r')
        f.read
      ensure
        f.close
      end
    end

    def installation_path
      origin_file_name
    end

    def file_name
      origin_file_name.split('/').last
    end

    def subpath
      "home/engines/#{origin_path}"
    end

    def origin_path
      origin_file_name[break_point .. -1].split('/')[0 .. -2].join('/')
    end

    def break_point
      origin_file_name.index("#{directory}")
    end

    def initialize(origin:, directory:, context:)
      self.context = context
      self.origin_file_name = origin
      self.directory = directory
    end

  end
end
