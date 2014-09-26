module LoadTests
  module Line
    class AbstractLine
      attr_reader :data

      def initialize(data, highest_10sec_mean=0)
        @data = data
        @highest_10sec_mean = highest_10sec_mean
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
