module MetaHelper
  def find_the_thing
    @find_the_thing ||= [@article, @page, @podcast, @episode, @book, @tool, @video].compact.first
  end

  def meta_type thing
    thing.present? ? 'article' : 'website'
  end

  def meta_title thing = nil
    # TODO: should be thing.name instead?
    thing.present? ? thing.title : t('head.meta_title')
  end

  def meta_description thing
    thing.present? ? thing.meta_description : t('head.meta_description')
  end

  def meta_image thing
    if thing.present? && thing.image.present? && thing.respond_to?(:meta_image)
      thing.meta_image
    else
      t('head.meta_image_url')
    end
  end

  def page_title
    if @title.nil?
      PageTitle.new.content
    elsif @title.is_a? PageTitle
      @title.content
    else
      @title
    end
  end
end
