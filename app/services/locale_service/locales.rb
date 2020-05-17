class LocaleService::Locales # rubocop:disable Style/ClassAndModuleChildren
  Locale = LocaleService::Locale

  LOCALES = [
    # ar: arabic
    Locale.new(locale: 'arabic',      lang_code: :ar, canonical: 'alarabiyawu'),
    Locale.new(locale: 'alarabiyawu', lang_code: :ar, canonical: 'alarabiyawu'),
    Locale.new(locale: 'اَلْعَرَبِيَّةُ', lang_code: :ar, canonical: 'alarabiyawu'),

    # bn: bengali
    Locale.new(locale: 'bengali', lang_code: :bn, canonical: 'baanlaa'),
    Locale.new(locale: 'baanlaa', lang_code: :bn, canonical: 'baanlaa'),
    Locale.new(locale: 'বাংলা', lang_code: :bn, canonical: 'baanlaa'),

    # cs: czech
    Locale.new(locale: 'czech',   lang_code: :cs, canonical: 'cestina'),
    Locale.new(locale: 'čeština', lang_code: :cs, canonical: 'cestina'),
    Locale.new(locale: 'cestina', lang_code: :cs, canonical: 'cestina'),

    # da: danish
    Locale.new(locale: 'danish', lang_code: :da, canonical: 'dansk'),
    Locale.new(locale: 'dansk',  lang_code: :da, canonical: 'dansk'),

    # de: german
    Locale.new(locale: 'deutsch', lang_code: :de, canonical: 'deutsch'),
    Locale.new(locale: 'german',  lang_code: :de, canonical: 'deutsch'),

    # en: english
    Locale.new(locale: 'english', lang_code: :en, canonical: 'english'),

    # es: spanish
    Locale.new(locale: 'espanol', lang_code: :es, canonical: 'espanol'),
    Locale.new(locale: 'spanish', lang_code: :es, canonical: 'espanol'),
    Locale.new(locale: 'español', lang_code: :es, canonical: 'espanol'),

    # fa: farsi
    Locale.new(locale: 'farsi', lang_code: :fa, canonical: 'frsy'),
    Locale.new(locale: 'frsy',  lang_code: :fa, canonical: 'frsy'),
    Locale.new(locale: 'فارسی', lang_code: :fa, canonical: 'frsy'),

    # fi: finnish
    Locale.new(locale: 'suomen',  lang_code: :fi, canonical: 'suomen'),
    Locale.new(locale: 'finnish', lang_code: :fi, canonical: 'suomen'),

    # fr: french
    Locale.new(locale: 'français', lang_code: :fr, canonical: 'francais'),
    Locale.new(locale: 'francais', lang_code: :fr, canonical: 'francais'),
    Locale.new(locale: 'french',   lang_code: :fr, canonical: 'francais'),

    # gr: greek
    Locale.new(locale: 'ελληνικά', lang_code: :gr, canonical: 'ellenika'),
    Locale.new(locale: 'ellenika', lang_code: :gr, canonical: 'ellenika'),
    Locale.new(locale: 'greek',    lang_code: :gr, canonical: 'ellenika'),

    # he: hebrew
    Locale.new(locale: 'hebrew',   lang_code: :he, canonical: 'ibriyt'),
    Locale.new(locale: 'ibriyt',   lang_code: :he, canonical: 'ibriyt'),
    Locale.new(locale: 'עִבְרִית', lang_code: :he, canonical: 'ibriyt'),

    # id: indonesian
    Locale.new(locale: 'indonesian',       lang_code: :id, canonical: 'bahasa-indonesia'),
    Locale.new(locale: 'bahasa-indonesia', lang_code: :id, canonical: 'bahasa-indonesia'),

    # it: italian
    Locale.new(locale: 'italian',  lang_code: :it, canonical: 'italiano'),
    Locale.new(locale: 'italiano', lang_code: :it, canonical: 'italiano'),

    # ja: japanese
    Locale.new(locale: 'japanese',  lang_code: :ja, canonical: 'ri-ben-yu'),
    Locale.new(locale: 'ri-ben-yu', lang_code: :ja, canonical: 'ri-ben-yu'),
    Locale.new(locale: '日本語', lang_code: :ja, canonical: 'ri-ben-yu'),

    # dv: maldivian
    Locale.new(locale: 'maldivian', lang_code: :dv, canonical: 'dhivehi'),
    Locale.new(locale: 'dhivehi',   lang_code: :dv, canonical: 'dhivehi'),
    Locale.new(locale: 'ދިވެހި', lang_code: :dv, canonical: 'dhivehi'),

    # pl: polish
    Locale.new(locale: 'polski', lang_code: :pl, canonical: 'polski'),
    Locale.new(locale: 'polish', lang_code: :pl, canonical: 'polski'),

    # pt: portuguese
    Locale.new(locale: 'portuguese', lang_code: :pt, canonical: 'portugues-brasileiro'),
    Locale.new(locale: 'portugués',  lang_code: :pt, canonical: 'portugues-brasileiro'),
    Locale.new(locale: 'portugues',  lang_code: :pt, canonical: 'portugues-brasileiro'),

    # pt-br: portuguese, brazilian
    Locale.new(locale: 'brazilian portuguese', lang_code: :pt, canonical: 'portugues-brasileiro'),
    Locale.new(locale: 'brazilian-portuguese', lang_code: :pt, canonical: 'portugues-brasileiro'),
    Locale.new(locale: 'português brasileiro', lang_code: :pt, canonical: 'portugues-brasileiro'),
    Locale.new(locale: 'português-brasileiro', lang_code: :pt, canonical: 'portugues-brasileiro'),
    Locale.new(locale: 'portugues-brasileiro', lang_code: :pt, canonical: 'portugues-brasileiro'),

    # ru: russian
    Locale.new(locale: 'русский', lang_code: :ru, canonical: 'russkii'),
    Locale.new(locale: 'russian', lang_code: :ru, canonical: 'russkii'),
    Locale.new(locale: 'russkii', lang_code: :ru, canonical: 'russkii'),

    # sl: slovenian
    Locale.new(locale: 'slovenian',   lang_code: :sl, canonical: 'slovenscina'),
    Locale.new(locale: 'slovenščina', lang_code: :sl, canonical: 'slovenscina'),
    Locale.new(locale: 'slovenscina', lang_code: :sl, canonical: 'slovenscina'),

    # sv: swedish
    Locale.new(locale: 'swedish', lang_code: :sv, canonical: 'svenska'),
    Locale.new(locale: 'svenska', lang_code: :sv, canonical: 'svenska'),

    # th: thai
    Locale.new(locale: 'thai',         lang_code: :th, canonical: 'phaasaaaithy'),
    Locale.new(locale: 'phaasaaaithy', lang_code: :th, canonical: 'phaasaaaithy'),
    Locale.new(locale: 'ภาษาไทย',      lang_code: :th, canonical: 'phaasaaaithy'),

    # tr: turkish
    Locale.new(locale: 'turkish', lang_code: :tr, canonical: 'turkce'),
    Locale.new(locale: 'türkçe',  lang_code: :tr, canonical: 'turkce'),
    Locale.new(locale: 'turkce',  lang_code: :tr, canonical: 'turkce'),

    # zh: chinese
    Locale.new(locale: 'chinese',     lang_code: :zh, canonical: 'pu-tong-hua'),
    Locale.new(locale: 'pu-tong-hua', lang_code: :zh, canonical: 'pu-tong-hua'),
    Locale.new(locale: '普通話', lang_code: :zh, canonical: 'pu-tong-hua')
  ].freeze

  class << self
    def canonical locale:, lang_code: nil
      return LOCALES.find { |locale_instance| locale_instance.locale == locale } if lang_code.blank?

      @indexed_locales.dig(lang_code) || raise_locale_error(locale)
    end

    private

    def index_locales
      @indexed_locales = LOCALES.each_with_object({}) do |locale, hash|
        hash[locale.lang_code] ||= locale
      end
    end

    def raise_locale_error locale
      raise ArgumentError, "No mapping for the locale #{locale} was found. Maybe a mapping needs to be added?"
    end
  end

  index_locales
end
