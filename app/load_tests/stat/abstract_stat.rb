module LoadTests
  module Stat
    class AbstractStat
      attr_reader :data

      def initialize(data, highest_10sec_mean=0)
        @data = data
        @highest_10sec_mean = highest_10sec_mean
      end

      def name
        :stat
      end

      def to_hash
        {}
      end
    end
  end
end
