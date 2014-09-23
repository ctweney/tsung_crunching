require 'application.rb'
require 'Find'

class Crunch
  def self.run
    all_results = {}
    p "Looking for tsung.log files under #{Application.results_dir}"
    Find.find(Application.results_dir) { |path|
      if File.basename(path) == 'tsung.log'
        parent_name = File.basename(File.dirname(path))
        file = LoadTests::File.new path
        file_data = file.process
        all_results[parent_name] = file_data if file_data.present? && file_data.keys.length
      end
    }

    p "All results before JSON conversion: #{all_results}"

    json = {
      highest_cpu: [],
      lowest_memory: []
    }

    count = 0
    all_results.keys.sort.each do |key|
      if all_results[key][:cpu].present?
        count += 1
        json[:highest_cpu] << [count, all_results[key][:cpu][:highest], "#{key}: #{all_results[key][:cpu][:highest]}%" ]
      end
    end

    count = 0
    all_results.keys.sort.each do |key|
      if all_results[key][:memory].present?
        count += 1
        json[:lowest_memory] << [count, all_results[key][:memory][:lowest], "#{key}: #{all_results[key][:memory][:lowest]}MB" ]
      end
    end

    outfile = File.open(File.join(Application.output_dir, 'tsung_test_data.js'), 'w')
    outfile.write("tsung_test_data = #{json.to_json};")
    outfile.close
    p "Test summary data written to #{outfile.path}"

    FileUtils.cp File.join(Application.root, 'app', 'html', 'test_comparison_graphs.html'), File.join(Application.output_dir)
  end
end
