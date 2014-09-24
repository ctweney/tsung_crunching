module LoadTests
  class AllResults
    def initialize(directory = Application.results_dir)
      @directory = directory
    end

    def get
      all_results = {}
      puts "Looking for tsung.log files under #{@directory}"
      Find.find(@directory) { |path|
        if ::File.basename(path) == 'tsung.log'
          parent_name = ::File.basename(::File.dirname(path))
          file = LoadTests::File.new path
          file_data = file.process
          all_results[parent_name] = file_data if file_data.present? && file_data.keys.length
        end
      }
      all_results
    end
  end
end
