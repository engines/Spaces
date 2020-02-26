require_relative '../spaces/model'
require_relative 'infix'

module Texts
  class Text < ::Spaces::Model

    relation_accessor :context,
      :source_file_name,
      :content

    def resolved
      immutable_strings.zip(infixes.map(&:resolved)).flatten.join
    end

    def infixes
      splits(:odd?).map { |s| infix_class.new(value: s, context: self) }
    end

    def infix_class
      Infix
    end

    def immutable_strings
      splits(:even?)
    end

    def splits(method)
      content.split(interpolation_marker).select.with_index { |_, i| i.send(method) }
    end

    def content
      @content ||= source_content
    end

    def source_content
      f = File.open(source_file_name, 'r')
      begin
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

    def interpolation_marker
      '^^'
    end

    def tensor
      context.tensor
    end

    def initialize(source_file_name:, context:)
      self.context = context
      self.source_file_name = source_file_name
    end

  end
end
