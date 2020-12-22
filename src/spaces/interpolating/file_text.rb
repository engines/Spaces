require_relative 'text'

module Interpolating
  class FileText < Text

    attr_accessor :origin_file_name,
      :directory
      # :origin

    def origin
      @origin ||= origin_file_name.read
    end

    def permission
      @permission ||= origin_file_name.stat.mode
    end

    def emission_path; origin_file_name ;end

    def file_name; origin_file_name.basename ;end

    def subpath; origin_path ;end

    def origin_path; origin_file_name.dirname ;end

    def to_s; origin_file_name.to_s ;end

    def initialize(origin:, directory:, transformable:)
      self.transformable = transformable
      self.origin_file_name = origin
      self.directory = directory
    end

  end
end
