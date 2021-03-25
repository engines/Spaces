module Tests

  def publishing

    group 'Import publication' do

      identifier = 'phpmyadmin'
      repository = 'https://github.com/MarkRatjens/phpmyadmin'

      test 'index publications before create' do
        output universe.publications.identifiers
      end

      test 'import publication' do
        descriptor = Spaces::Descriptor.new(repository: repository)
        output universe.publications.import(descriptor, force: true)
      end

      test 'index publications after create' do
        output identifiers = universe.publications.identifiers
        raise "#{identifier} not created" unless
        identifiers.map(&:to_s).include?(identifier)
      end

      test 'show publication' do
        output publication = universe.publications.by(identifier)
        output publication.to_yaml
      end

      test 'delete publication' do
        output publication = universe.publications.by(identifier)
        output universe.publications.delete(publication)
      end

      test 'index publications after delete' do
        output identifiers = universe.publications.identifiers
        raise "#{identifier} not deleted" if
        identifiers.map(&:to_s).include?(identifier)
      end

    end

    group 'Export blueprint to publication' do

      # [
      #   'https://github.com/MarkRatjens/phpmyadmin/'
      #   # 'file:///var/tmp/git/phpmyadmin'
      # ].each do |repository_url|
      #
      #   descriptor = Spaces::Descriptor.new(repository: repository_url)
      #   identifier = descriptor.identifier
      #
      #   test "import publication #{identifier}" do
      #     output universe.publications.import(descriptor)
      #   end
      #
      #   test "index publications after import #{identifier}" do
      #     output identifiers = universe.publications.identifiers
      #     raise "publication not imported" unless
      #     identifiers.map(&:to_s).include?(identifier)
      #   end
      #
      #   test "show publication after import #{identifier}" do
      #     output publication = universe.publications.by(identifier)
      #     output publication.to_yaml
      #   end
      #
      # end

    end

  end
end
