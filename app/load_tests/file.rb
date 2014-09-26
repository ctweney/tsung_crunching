module LoadTests
  class File

    def initialize(filename)
      @filename = filename
    end

    def process
      lines = []
      lines << find_last_occurrence('{cpu', LoadTests::Line::CpuLine)
      lines << find_last_occurrence('{freemem', LoadTests::Line::MemoryLine)
      lines << find_last_occurrence('session', LoadTests::Line::SessionLine, true)
      lines << find_last_occurrence('stats: 5\d\d', LoadTests::Line::Error5xxLine)

      results = {
        run_date: find_date.to_i
      }
      lines.each do |line|
        results[line.name] = line.to_hash if line
      end
      results
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
