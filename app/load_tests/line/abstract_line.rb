module LoadTests
  module Line
    class AbstractLine
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
end
