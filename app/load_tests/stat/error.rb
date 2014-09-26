module LoadTests
  module Stat
    class Error < AbstractStat

      def name
        # name is equal to the HTTP status code.
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
