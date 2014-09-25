require 'application'

describe LoadTests::GoogleChartsJsonConverter do

  let(:all_results) { LoadTests::AllResults.new(File.join(Application.root, 'fixtures', 'tsung')).get }
  subject { LoadTests::GoogleChartsJsonConverter.new(all_results).convert }

  it {
    puts "Google Charts JSON Data: #{subject}"
    expect(subject).to be
    expect(subject[:highest_cpu][0][0]).to eq 1
    expect(subject[:highest_cpu][0][1]).to eq 252.2
    expect(subject[:highest_cpu][0][2]).to eq "1: 252.2%"
    expect(subject[:highest_cpu][1][0]).to eq 2
    expect(subject[:lowest_memory][0][0]).to eq 1
    expect(subject[:lowest_memory][0][1]).to eq 3852.1
  }

end
