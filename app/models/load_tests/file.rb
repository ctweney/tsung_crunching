module LoadTests
  class File

    require 'elif'

    TOTAL_NUMBER_OF_COUNTERS = 3

    def initialize(filename)
      @filename = filename
    end

    def process
      count = 0
      results = {}
      # Use Elif to process file from the end, because we're only interested in the last log entry of each type.
      ::Elif.foreach(@filename) { |raw_line|
        line = LoadTests::LineFactory.get raw_line
        if line
          results[line.name] = line.to_hash
          count += 1
          if count == TOTAL_NUMBER_OF_COUNTERS
            break # stop processing log when we have all the categories we expect
          end
        end
      }
      results
    end
  end
end
