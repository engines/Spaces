require_relative 'text'

module Interpolating
  class FileText < Text

    attr_accessor :origin_file_name,
      :directory,
      :origin

    delegate(context_identifier: :division)

    def origin
      @origin ||= ::File.read(origin_file_name)
    end

    def emission_path; origin_file_name ;end

    def file_name; origin_file_name.split('/').last ;end

    def subpath; origin_path ;end
    def origin_path; origin_file_name[break_point .. -1].split('/')[0 .. -2].join('/') ;end
    def break_point; origin_file_name.index("#{directory}") ;end
    def to_s; origin_file_name ;end

    def initialize(origin:, directory:, division:)
      self.division = division
      self.origin_file_name = origin
      self.directory = directory
    end

  end
end
