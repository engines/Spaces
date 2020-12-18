module Tests

  def resolutions

    group 'CRUD resolutions' do

      identifier = 'phpmyadmin'
      descriptor = Spaces::Descriptor.new(identifier: identifier)

      test "show #{identifier} resolution" do
        output universe.resolutions.by(identifier).to_s
      end

      test "index includes #{identifier}" do
        output identifiers = universe.resolutions.identifiers
        raise "#{identifier} not created" unless
        identifiers.map(&:to_s).include?(identifier)
      end

      test 'delete' do
        output resolution = universe.resolutions.by(identifier)
        output universe.resolutions.delete(resolution)
      end

      test 'index after delete' do
        output identifiers = universe.resolutions.identifiers
        raise "#{identifier} not deleted" if
        identifiers.map(&:to_s).include?(identifier)
      end

    end

  end
end
