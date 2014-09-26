module LoadTests
  module Stat
    class Error5xx < AbstractStat
      def name
        :error5xx
      end

      def to_hash
        {
          count: data[2].to_i
        }
      end
    end
  end
end
