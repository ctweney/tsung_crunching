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

      @results.keys.sort.each do |key|
        if @results[key][:cpu].present?
          json[:highest_cpu] << [@results[key][:run_date], @results[key][:cpu][:highest], "#{key}: #{@results[key][:cpu][:highest]}%"]
        end
      end

      @results.keys.sort.each do |key|
        if @results[key][:memory].present?
          json[:lowest_memory] << [@results[key][:run_date], @results[key][:memory][:lowest], "#{key}: #{@results[key][:memory][:lowest]}MB"]
        end
      end

      @results.keys.sort.each do |key|
        if @results[key][:session].present?
          json[:session_mean] << [
            @results[key][:run_date],
            @results[key][:session][:mean], "#{key}: #{@results[key][:session][:mean]}ms",
            @results[key][:session][:highest_10sec_mean], "#{key}: #{@results[key][:session][:highest_10sec_mean]}ms"
          ]
        end
      end

      @results.keys.sort.each do |key|
        errs = [@results[key][:run_date]]
        if @results[key][:error5xx].present?
          errs << @results[key][:error5xx][:count]
          errs << "#{key}: #{@results[key][:error5xx][:count]} 500-series errors"
        else
          errs << 0
          errs << 0
        end

        if @results[key][:error4xx].present?
          errs << @results[key][:error4xx][:count]
          errs << "#{key}: #{@results[key][:error4xx][:count]} 400-series errors"
        else
          errs << 0
          errs << 0
        end
        json[:error_count] << errs
      end

      json

    end
  end
end
