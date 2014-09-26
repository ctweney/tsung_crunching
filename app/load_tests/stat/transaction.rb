module LoadTests
  module Stat
    class Transaction < AbstractStat

      def name
        data[1].to_s.to_sym
      end

      def to_hash
        {
          mean: data[7].to_f.round(1),
          highest_10sec_mean: @highest_10sec_mean.to_f.round(1)
        }
      end
    end
  end
end
