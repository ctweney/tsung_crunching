require 'application'

describe LoadTests::File do

  subject { LoadTests::File.new(File.join(Application.root, 'fixtures', 'tsung', '1', 'tsung.log')).process }

  it {
    p "File contents: #{subject}"
    expect(subject).to be
    expect(subject[:run_date]).to eq 1411394598
    expect(subject[:cpu][:highest]).to eq 252.2
    expect(subject[:cpu][:lowest]).to eq 1.8
    expect(subject[:memory][:highest]).to eq 4199.3
    expect(subject[:memory][:lowest]).to eq 3852.1
    expect(subject[:session][:mean]).to eq 95596.7
    expect(subject[:session][:highest_10sec_mean]).to eq 113181.9
    expect(subject[:error5xx][:count]).to eq 37
    expect(subject[:error4xx][:count]).to eq 12
  }
end
