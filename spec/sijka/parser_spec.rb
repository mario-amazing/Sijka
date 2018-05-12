require 'sijka'

RSpec.describe Sijka::SijkaParser do
  let(:argv) { [] }

  before do
    stub_const('ARGV', argv)
  end

  describe '#parse_flags' do
    subject { Sijka::SijkaParser.new(argv).parse_flags }

    context 'random file' do
      let(:argv) { ['-r'] }

      it 'contains right key' do
        expect(subject).to include('sijkafile')
      end

      it 'contains right value' do
        expect(Sijka::Sijka::FILE_LIST).to include(subject['sijkafile'])
      end
    end

    context 'fils list' do
      let(:argv) { ['-l'] }

      it 'contains right key' do
        expect(subject).to include('list')
      end

      it 'contains right value' do
        expect(subject['list']).to be(true)
      end
    end

    context 'fils list' do
      let(:file_name) { 'FAKE name' }
      let(:argv) { ['-f', file_name] }

      it 'contains right key' do
        expect(subject).to include('sijkafile')
      end

      it 'contains right value' do
        expect(subject['sijkafile']).to eq(file_name)
      end
    end
  end

  describe '#parse_message' do
    subject { Sijka::SijkaParser.new(argv).parse_message }

    context 'argv present' do
      let(:argv) { %w[first second] }
      let(:expected_message) { argv.join(' ') }

      it { is_expected.to eq(expected_message) }
    end

    context 'argv blank' do
      let(:expected_message) { '' }

      it { is_expected.to eq(expected_message) }
    end
  end
end
