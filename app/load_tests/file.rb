module LoadTests
  class File

    def initialize(filename)
      @filename = filename
    end

    def process
      lines = []
      lines << find_last_occurrence('{cpu', LoadTests::Line::CpuLine)
      lines << find_last_occurrence('{freemem', LoadTests::Line::MemoryLine)
      lines << find_last_occurrence('session', LoadTests::Line::SessionLine)
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
        DateTime.strptime(epoch,'%s')
      else
        0
      end
    end

    def find_last_occurrence(regex, line_class)
      match = `egrep "#{regex}" #{@filename} | tail -1`
      if match.present?
        raw_data = match.split ' '
        line_class.new raw_data
      else
        nil
      end
    end

  end
end
