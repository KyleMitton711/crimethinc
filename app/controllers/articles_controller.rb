class ArticlesController < ApplicationController
  skip_before_action :check_for_redirection, only: :index

  def index
    @articles = Article.includes(:tags, :categories).live.published.root.page(params[:page]).per(10)

    render_json_feed if params[:format] == 'json'
  end

  def show
    @body_id = 'article'

    # get the article
    if %r{^/drafts}.match?(request.path)
      @article = Article.find_by(draft_code: params[:draft_code])

      return redirect_to(@article.path) if @article&.published?

      @collection_posts = @article.collection_posts.chronological if @article.present?

    else
      @article = Article.live.where(year: params[:year])
                        .where(month: params[:month])
                        .where(day:   params[:day])
                        .where(slug:  params[:slug]).first
      @collection_posts = @article.collection_posts.published.live.chronological if @article.present?
    end

    # no article found, go to /articles feed
    return redirect_to root_path if @article.blank?

    # redirect from draft URL to proper URL
    return redirect_to @article.path if @article.published? && params[:draft_code].present?

    # redirect to parent article, never show nested articles directly
    return redirect_to Article.find(@article.collection_id).path if @article.collection_id.present?

    @title = @article.name

    @previous_article = Article.previous(@article).first
    @next_article     = Article.next(@article).first
    @editable         = @article

    # save view stats
    Article.increment_counter(:page_views, @article.id) unless signed_in?

    render html: @article.content.html_safe, layout: false if @article.hide_layout?
  end

  private

  def render_json_feed
    items = []

    @articles.each do |article|
      items << {
        id:  root_url + article.path,
        url: root_url + article.path,
        title: article.name,
        summary: article.summary,
        image: article.image,
        banner_image: article.image,
        date_published: article.published_at.to_formatted_s(:iso8601),
        date_modified: article.updated_at.to_formatted_s(:iso8601),
        tags: article.tags.map(&:name).compact,
        content_html: article.content_rendered
      }
    end

    json_feed = {
      version:       'https://jsonfeed.org/version/1',
      user_comment:  'I support your decision, I believe in change and hope you find just what it is that you are looking for.
                     ::: If your heart is free, the ground you stand on is liberated territory. Defend it. :::
                     This feed allows you to read the posts from this site in any feed reader that supports the JSON Feed format.
                     To add this feed to your reader, copy the following URL — https://crimethinc.com/feed.json — and add it your reader.
                     ::: For more info on this format: https://jsonfeed.org ',
      title:         page_title,
      description:   meta_title,
      home_page_url: root_url,
      feed_url:      json_feed_url,
      next_url:      [json_feed_url, '?page=', params[:page].present? ? params[:page].to_i + 1 : 2].join,
      icon:          view_context.asset_url('icons/icon-600x600.png'),
      favicon:       view_context.asset_url('icons/icon-70x70.png'),

      author: {
        name: author,
        url:  root_url,
        avatar: view_context.asset_url('icons/icon-600x600.png')
      },

      items: items
    }

    render json: JSON.pretty_generate(json_feed)
  end
end
