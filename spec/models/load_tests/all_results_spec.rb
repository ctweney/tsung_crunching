require 'application'

describe LoadTests::AllResults do
  subject { LoadTests::AllResults.new(File.join(Application.root, 'fixtures', 'tsung')).get }

  it {
    puts "AllResults data: #{subject}"
    expect(subject.keys.length).to eq 2
    expect(subject['1'][:cpu][:highest]).to eq 252.2
    expect(subject['2'][:cpu][:highest]).to eq 261.3
  }

end
