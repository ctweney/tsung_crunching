module LoadTests
  class GoogleChartsJsonConverter
    def initialize(results = {})
      @results = results
    end

    def convert
      json = {
        highest_cpu: [],
        lowest_memory: []
      }

      count = 0
      @results.keys.sort.each do |key|
        if @results[key][:cpu].present?
          count += 1
          json[:highest_cpu] << [count, @results[key][:cpu][:highest], "#{key}: #{@results[key][:cpu][:highest]}%" ]
        end
      end

      count = 0
      @results.keys.sort.each do |key|
        if @results[key][:memory].present?
          count += 1
          json[:lowest_memory] << [count, @results[key][:memory][:lowest], "#{key}: #{@results[key][:memory][:lowest]}MB" ]
        end
      end

      json

    end
  end
end
