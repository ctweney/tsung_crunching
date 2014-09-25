module LoadTests
  module Line
    class CpuLine < AbstractLine
      def name
        :cpu
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
