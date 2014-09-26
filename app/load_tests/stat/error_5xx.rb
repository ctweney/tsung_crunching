module LoadTests
  module Stat
    class Error5xx < AbstractStat

      def name
        data[1].to_s.to_sym
      end

      def to_hash
        {
          count: data[2].to_i
        }
      end
    end
  end
end
