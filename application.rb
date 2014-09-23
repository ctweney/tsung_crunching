require 'require_all'
require 'active_support/all'

require_all 'app'

module Application
  def self.root
    File.dirname(__FILE__)
  end

  def self.results_dir
    ENV['RESULTS_DIR'] || File.join(Application.root, 'results')
  end

  def self.output_dir
    ENV['OUTPUT_DIR'] || Application.root
  end

end

