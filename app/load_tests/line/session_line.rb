module LoadTests
  module Line
    class SessionLine < AbstractLine

      def name
        :session
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
