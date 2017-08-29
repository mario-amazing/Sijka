require 'I18n'

module Sijka
  class Translator
    def initialize
      I18n.load_path = Dir.glob("#{$LOAD_PATH.first}/../locales/*.yml")
      I18n.enforce_available_locales = false
    end

    def smoken_with_locale(subject)
      I18n.t subject, locale: I18n.locale, default: I18n.t('sijka', locale: :en)
    end
  end
end
