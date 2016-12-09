class ArchivesController < ApplicationController
  def home
    @slug = "home"

    # feed
    @articles = Article.published.limit(5).all

    # pinned articles
    pinned_to_top_page_id    = setting(:pinned_to_top_page_id)
    pinned_to_bottom_page_id = setting(:pinned_to_bottom_page_id)

    if pinned_to_top_page_id.present?
      @pinned_to_top    = Page.find(pinned_to_top_page_id)
    end
    if pinned_to_bottom_page_id.present?
      @pinned_to_bottom = Page.find(pinned_to_bottom_page_id)
    end
  end

  def index
    @slug     = "archives"
    @articles = {}

    Article.unpinned.published.feed.all.each do |article|
      year  = article.published_at.year
      month = article.published_at.month

      @articles[year]        = {} if @articles[year].nil?
      @articles[year][month] = [] if @articles[year][month].nil?

      @articles[year][month] << article
    end
  end
end
