module LoadTests
  class File

    def initialize(filename)
      @filename = filename
    end

    def process
      lines = []
      lines << find_last_occurrence('{cpu', LoadTests::Stat::Cpu)
      lines << find_last_occurrence('{freemem', LoadTests::Stat::Memory)
      lines << find_last_occurrence('session', LoadTests::Stat::Session, true)
      lines << find_last_occurrence('stats: 5\d\d', LoadTests::Stat::Error5xx)
      lines << find_5xx_errors

      results = {
        run_date: find_date.to_i
      }
      lines.each do |line|
        results[line.name] = line.to_hash if line
      end
      results
    end

    def find_5xx_errors
      errors = []
      errors << find_last_occurrence('stats: 500', LoadTests::Stat::Error5xx)
      errors << find_last_occurrence('stats: 502', LoadTests::Stat::Error5xx)
      errors << find_last_occurrence('stats: 503', LoadTests::Stat::Error5xx)

      composite_errors = ['stats', 'error5xx', 0]
      errors.each do |error|
        composite_errors[2] += error.to_hash[:count] if error.present?
      end
      LoadTests::Stat::Error5xx.new composite_errors
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
