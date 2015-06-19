module LoadTests
  class File

    def initialize(filename)
      @filename = filename
    end

    def process
      lines = []
      lines << find_last_occurrence('{cpu', LoadTests::Stat::Cpu)
      lines << find_last_occurrence('{freemem', LoadTests::Stat::Memory)
      lines << find_last_occurrence('session', LoadTests::Stat::Transaction, true)
      lines << find_last_occurrence('tr_api_endpoints', LoadTests::Stat::Transaction, true)
      lines << summarize_errors('error5xx', [500, 502, 503])
      lines << summarize_errors('error4xx', [400, 401, 403, 404])

      results = {
        run_date: find_date.to_i
      }
      lines.each do |line|
        results[line.name] = line.to_hash if line
      end
      results
    end

    def summarize_errors(label, codes)
      composite_errors = ['stats', label, 0]
      codes.each do |code|
        error = find_last_occurrence("stats: #{code}", LoadTests::Stat::Error)
        composite_errors[2] += error.to_hash[:count] if error.present?
      end
      LoadTests::Stat::Error.new composite_errors
    end

    def find_date
      match = `egrep "stats: dump at" #{@filename} | head -1`
      if match
        epoch = match.split(' ')[4]
        DateTime.strptime(epoch, '%s')
      else
        0
      end
    end

    def find_last_occurrence(regex, line_class, get_highest_10sec_mean = false)
      match = `egrep "#{regex}" #{@filename} | tail -1`
      if match.present?
        raw_data = match.split ' '
        if get_highest_10sec_mean
          highest = find_highest_10sec_mean regex
          line_class.new raw_data, highest
        else
          line_class.new raw_data
        end
      else
        nil
      end
    end

    def find_highest_10sec_mean(regex)
      matches = `egrep "#{regex}" #{@filename}`
      maximum = 0
      if matches
        matches.split("\n").each do |match|
          this_max = match.split(' ')[3].to_f
          if this_max > maximum
            maximum = this_max
          end
        end
      end
      maximum
    end

  end
end
