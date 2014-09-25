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

      results = {}
      lines.each do |line|
        results[line.name] = line.to_hash if line
      end
      results
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
