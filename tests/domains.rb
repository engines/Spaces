module Tests

  def domains

    group 'CRUD domains' do

      identifier = 'domain.for.test'

      test 'index before create' do
        output universe.domains.identifiers
      end

      test 'create' do
        output domain = Associations::Domain.new(identifier: identifier)
        output universe.domains.save(domain)
      end

      test 'index after create' do
        output identifiers = universe.domains.identifiers
        raise "#{identifier} not created" unless
        identifiers.map(&:to_s).include?(identifier)
      end

      test 'show' do
        output domain = universe.domains.by(identifier)
        output domain.to_h.to_yaml
      end

      test 'delete' do
        output domain = universe.domains.by(identifier)
        output universe.domains.delete(domain)
      end

      test 'index after delete' do
        output identifiers = universe.domains.identifiers
        raise "#{identifier} not deleted" if
        identifiers.map(&:to_s).include?(identifier)
      end

    end

  end
end
