module LoadTests
  module Line
    class Error5xxLine < AbstractLine
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
