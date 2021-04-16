module Emissions
  module Content

    def auxiliary_files
      ['icon', 'README.md', 'LICENSE.md']
    end

    def auxiliary_folders
      [:packing, :commissioning, :service_tasks]
    end

    def content
      [divisions_content, blueprints_content].flatten
    end

    def divisions_content
      divisions.map { |d| d.content }.flatten.compact
    end

    def blueprints_content
      auxiliary_folders.map { |d| content_into(d, source: itself) }.flatten
    end

    def content_into(directory, source:)
      blueprints.file_names_for(directory, source.context_identifier).map do |t|
        Interpolating::FileText.new(origin: t, directory: directory, transformable: self)
      end
    end

  end
end
