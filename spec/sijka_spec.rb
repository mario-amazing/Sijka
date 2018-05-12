require 'sijka'

RSpec.describe Sijka::Sijka do
  let(:argv) { [] }

  before do
    stub_const('ARGV', argv)
  end

  describe '#new' do
    subject { Sijka::Sijka.new(argv) }

    context 'options present' do
      let(:argv) { ['-l'] }

      it 'contains right key' do
        expect(subject.options).to include('list')
      end
    end

    context 'message present' do
      context 'without flags' do
        let(:argv) { %w[first second] }
        let(:expected_message) { argv.join(' ') }

        it { expect(subject.message).to eq(expected_message) }
      end

      context 'with flags' do
        let(:expected_message) { 'second' }
        let(:argv) { ['-f', 'file_name', expected_message] }

        it { expect(subject.message).to eq(expected_message) }
      end
    end
  end

  describe '#smoke' do
    let(:argv) { [] }
    let(:smoke_double) { double(smoke: nil) }

    subject { Sijka::Sijka.new(argv).smoke }

    before do
      allow(Sijka::Smoke).to receive(:new).and_return(smoke_double)
    end

    context 'options list' do
      let(:argv) { ['-l'] }

      it 'puts list' do
        expect { subject }.to output.to_stdout
      end
    end

    context 'invoke smoke' do
      it do
        expect(Sijka::Smoke.new('fake options', 'fake message')).to receive(:smoke)
        subject
      end
    end
  end
end
