module LoadTests
  class GoogleChartsJsonConverter
    def initialize(results = {})
      @results = results
    end

    def convert
      json = {
        highest_cpu: [],
        lowest_memory: [],
        session_mean: [],
        error_count: []
      }

      count = 0
      @results.keys.sort.each do |key|
        if @results[key][:cpu].present?
          count += 1
          json[:highest_cpu] << [@results[key][:run_date], @results[key][:cpu][:highest], "#{key}: #{@results[key][:cpu][:highest]}%"]
        end
      end

      count = 0
      @results.keys.sort.each do |key|
        if @results[key][:memory].present?
          count += 1
          json[:lowest_memory] << [@results[key][:run_date], @results[key][:memory][:lowest], "#{key}: #{@results[key][:memory][:lowest]}MB"]
        end
      end

      count = 0
      @results.keys.sort.each do |key|
        if @results[key][:session].present?
          count += 1
          json[:session_mean] << [
            @results[key][:run_date],
            @results[key][:session][:mean], "#{key}: #{@results[key][:session][:mean]}ms",
            @results[key][:session][:highest_10sec_mean], "#{key}: #{@results[key][:session][:highest_10sec_mean]}ms"
          ]
        end
      end

      count = 0
      @results.keys.sort.each do |key|
        if @results[key][:error5xx].present?
          count += 1
          json[:error_count] << [
            @results[key][:run_date],
            @results[key][:error5xx][:count], "#{key}: #{@results[key][:error5xx][:count]} errors"
          ]
        end
      end

      json

    end
  end
end
