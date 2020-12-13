module Tests

  def tenants

    group 'CRUD tenants' do

      identifier = 'tenant_for_test'

      test 'index before create' do
        output universe.tenants.identifiers
      end

      test 'create' do
        output tenant = Associations::Tenant.new(identifier: identifier)
        output universe.tenants.save(tenant)
      end

      test 'index after create' do
        output identifiers = universe.tenants.identifiers
        raise "#{identifier} not created" unless
        identifiers.map(&:to_s).include?(identifier)
      end

      test 'show' do
        output tenant = universe.tenants.by(identifier)
        output tenant.to_h.to_yaml
      end

      test 'delete' do
        output tenant = universe.tenants.by(identifier)
        output universe.tenants.delete(tenant)
      end

      test 'index after delete' do
        output identifiers = universe.tenants.identifiers
        raise "#{identifier} not deleted" if
        identifiers.map(&:to_s).include?(identifier)
      end

    end

  end
end
