require 'application'

describe LoadTests::File do

  subject { LoadTests::File.new(File.join(Application.root, 'fixtures', 'tsung', 'tsung.log')).process }

  it {
    expect(subject).to be
    expect(subject[:cpu][:highest]).to eq 252.2
    expect(subject[:cpu][:lowest]).to eq 1.8
    expect(subject[:memory][:highest]).to eq 4199.3
    expect(subject[:memory][:lowest]).to eq 3852.1
  }
end
