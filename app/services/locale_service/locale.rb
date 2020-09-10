class LocaleService::Locale # rubocop:disable Style/ClassAndModuleChildren
  attr_reader :locale, :lang_code, :canonical

  def initialize locale:, lang_code: nil, canonical: # rubocop:disable Style/KeywordParametersOrder
    @locale = locale
    @lang_code = lang_code
    @canonical = canonical
  end

  def to_h
    {
      locale:    locale,
      lang_code: lang_code,
      canonical: canonical
    }
  end
end
