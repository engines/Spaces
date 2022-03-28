module Images
  class Space < ::Emissions::InterfaceSpace

    def all
      super.select(&:tagged?)
    end

    def history(identifier) #TODO: what happens when there are multiple interfaces?
      interfaces.map { |i| i.by(identifier) }.first.history
    end

  end
end
