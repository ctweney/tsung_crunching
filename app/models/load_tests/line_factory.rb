module LoadTests
  class LineFactory
    def self.get(line)
      return nil if line.blank?
      raw_data = line.split ' '
      label = raw_data[1]

      case label
        when /\{cpu/
          LoadTests::CpuLine.new raw_data
        when /\{freemem/
          LoadTests::MemoryLine.new raw_data
        else
          nil
      end
    end
  end
end
