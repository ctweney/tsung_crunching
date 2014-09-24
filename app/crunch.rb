require 'application.rb'
require 'Find'

class Crunch
  def self.run
    all_results = LoadTests::AllResults.new.get
    puts "All results before JSON conversion: #{all_results}"
    json = LoadTests::GoogleChartsJsonConverter.new(all_results).convert

    outfile = File.open(File.join(Application.output_dir, 'tsung_test_data.js'), 'w')
    outfile.write("tsung_test_data = #{json.to_json};")
    outfile.close
    puts "Test summary data written to #{outfile.path}"

    FileUtils.cp File.join(Application.root, 'app', 'html', 'test_comparison_graphs.html'), File.join(Application.output_dir)
  end
end
