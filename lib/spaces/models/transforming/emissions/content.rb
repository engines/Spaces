module Emissions
  module Content

    def auxiliary_files = ['icon', 'README.md', 'LICENSE.md']

    def auxiliary_directories = [:packing, :commissioning, :servicing]

    def content = [divisions_content, blueprints_content].flatten

    def divisions_content = divisions.map { |d| d.content }.flatten.compact

    def blueprints_content =
      auxiliary_directories.map { |d| content_into(d, source: self) }.flatten

    def content_into(directory, source:)
      blueprints.file_names_for(directory, source.context_identifier).map do |t|
        Interpolating::FileText.new(origin: t, directory: directory, transformable: self)
      end
    end

  end
end
