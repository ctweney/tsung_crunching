require 'application'

describe LoadTests::GoogleChartsJsonConverter do

  let(:all_results) { LoadTests::AllResults.new(File.join(Application.root, 'fixtures', 'tsung')).get }
  subject { LoadTests::GoogleChartsJsonConverter.new(all_results).convert }

  it {
    puts "Google Charts JSON Data: #{subject}"
    expect(subject).to be
    expect(subject[:highest_cpu][0][0]).to eq 1411394598
    expect(subject[:highest_cpu][0][1]).to eq 252.2
    expect(subject[:highest_cpu][0][2]).to eq "1: 252.2%"
    expect(subject[:lowest_memory][0][0]).to eq 1411394598
    expect(subject[:lowest_memory][0][1]).to eq 3852.1
    expect(subject[:session_mean][0][0]).to eq 1411394598
    expect(subject[:session_mean][0][1]).to eq 95596.7
    expect(subject[:session_highest_10sec_mean][0][1]).to eq 113181.9
    expect(subject[:error_count][0][0]).to eq 1411394598
    expect(subject[:error_count][0][1]).to eq 37
    expect(subject[:tr_academics_mean][0][0]).to eq 1411394598
    expect(subject[:tr_academics_mean][0][1]).to eq 115.5
    expect(subject[:tr_academics_highest_10sec_mean][0][1]).to eq 389.4
    expect(subject[:tr_api_endpoints_mean][0][0]).to eq 1411394598
    expect(subject[:tr_api_endpoints_mean][0][1]).to eq 9800.3
    expect(subject[:tr_api_endpoints_highest_10sec_mean][0][1]).to eq 29273.6
  }

end
