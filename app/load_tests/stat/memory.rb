module LoadTests
  module Stat
    class Memory < AbstractStat

      def name
        :memory
      end

      def to_hash
        {
          highest: data[5].to_f.round(1),
          lowest: data[6].to_f.round(1)
        }
      end
    end
  end
end
