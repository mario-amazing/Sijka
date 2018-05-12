require 'sijka'

RSpec.describe Sijka::Translator do
  describe '#smoken_with_locale' do
    subject { Sijka::Translator.new.smoken_with_locale(translate_subject) }

    context 'subject present in locales' do
      let(:translate_subject) { 'duck' }
      let(:expected_message) { I18n.t(translate_subject) }

      it { is_expected.to eq(expected_message) }
    end

    context 'subject dosen\'t present in locales' do
      let(:translate_subject) { 'fake' }
      let(:expected_message) { I18n.t('sijka') }

      it { is_expected.to eq(expected_message) }
    end
  end
end
