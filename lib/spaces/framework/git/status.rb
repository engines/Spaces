module Git
  class Status

    attr_reader :files

    def commitable = files.select { |_, f| f.type }

    def map(&block) = files.values.map(&block)

  end
end
