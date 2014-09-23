module LoadTests
  class Line
    attr_reader :data

    def initialize(data)
      @data = data
    end

    def name
      :line
    end

    def to_hash
      {}
    end
  end
end
