require_relative 'text'

module Interpolating
  class FileText < Text

    attr_accessor :origin_file_name, :directory

    def origin; @origin ||= origin_file_name.read ;end

    def permission; @permission ||= origin_file_name.stat.mode ;end

    def emission_path; origin_file_name ;end

    def file_name; origin_file_name.basename ;end

    def subpath; origin_path ;end

    # Return the basename of the relative path from {origin_file_name} to
    # {directory}. The is quite confusing as there is an added complication: {directory}
    # is just a path segment. This method performs a reverse search for the rightmost
    # path segment and then uses that to calculate the relative path.
    #
    # @return [Pathname] the basename of the relative path from {origin_file_name} to the
    #         rightmost path segment matching {directory}.
    # @example
    #   Assuming:
    #     origin_file_name = Pathname("divisions/other_packages/packing/scripts/other_packages/add")
    #     directory = "other_packages"
    #
    #   then .origin_path => Pathname("divisions/other_packages/packing/scripts/other_packages")
    #
    #   Note that is has selected the rightmost instance of other_packages.
    def origin_path
      rel_path = rsearch_segment(origin_file_name, directory)
      origin_file_name.relative_path_from(rel_path.parent).dirname
    end

    def to_s
      origin_file_name.to_s
    end

    def initialize(origin:, directory:, transformable:)
      self.transformable = transformable
      self.origin_file_name = origin
      self.directory = directory
    end

    private

    # Performs a reverse search for the path segment in the path and returns the relative
    # path. Note the search segment will be the first segment in the returned path.
    #
    # @param path [Pathname] the path in which to search for {sepment}
    # @param segment [String] the path segment to search for
    # @return [Pathname] the absolute path of {segment} if it exists
    # @raise [KeyError] raise a KeyError if {segment} can't be found
    def rsearch_segment(path, segment)
      path.ascend.detect { |s| s.basename == segment } || (raise KeyError, "Cannot find path segment #{segment}")
    end
  end
end
