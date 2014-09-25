require 'application'

describe LoadTests::LineFactory do

  subject { LoadTests::LineFactory.get(log_line) }

  context 'a comment line' do
    let(:log_line) { '#' }
    it {
      expect(subject).to be_nil
    }
  end

  context 'a nil line' do
    let(:log_line) { nil }
    it {
      expect(subject).to be_nil
    }
  end

  context 'a CPU log line' do
    let(:log_line) { 'stats: {cpu,"ets-calcentral-dev-03.ist.berkeley.edu"} 1 1.8000000000465661 0.0 252.19999999995343 1.8000000000465661 105.42121212121165 99' }
    it {
      expect(subject).to be_instance_of LoadTests::CpuLine
      expect(subject.to_hash[:highest]).to eq 252.2
      expect(subject.to_hash[:lowest]).to eq 1.8
    }
  end

  context 'a free memory log line' do
    let(:log_line) { 'stats: {freemem,"ets-calcentral-dev-03.ist.berkeley.edu"} 1 3866.26 0.0 4199.328 3852.076 3939.58576 100' }
    it {
      expect(subject).to be_instance_of LoadTests::MemoryLine
      expect(subject.to_hash[:highest]).to eq 4199.3
      expect(subject.to_hash[:lowest]).to eq 3852.1
    }
  end

  context 'a session line' do
    let(:log_line) { 'stats: session 1 113181.93603515625 0.0 167725.68798828125 52.880859375 95596.69053588448 869' }
    it {
      expect(subject).to be_instance_of LoadTests::SessionLine
      expect(subject.to_hash[:mean]).to eq 95596.7
      expect(subject.to_hash[:highest_10sec_mean]).to eq 113181.9
    }
  end
end
