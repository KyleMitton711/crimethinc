class ArticlesController < ApplicationController
  def index
    @slug       = "articles"
    @page_title = "Articles"

    @articles_year  = params[:year]
    @articles_month = params[:month]
    @articles_day   = params[:day]

    @articles = Article.unpinned.published.feed.limit(5).all
    @articles = @articles.where(year:  params[:year])  if params[:year]
    @articles = @articles.where(month: params[:month]) if params[:month]
    @articles = @articles.where(day:   params[:day])   if params[:day]

    if @articles.length == 1
      return redirect_to @articles.first.path
    end

    # pinned articles
    @pinned_to_top    = Article.pinned_to_top.first
    @pinned_to_bottom = Article.pinned_to_bottom.first
  end

  def show
    @slug = "article"

    # get the article
    if request.path =~ /^\/drafts/
      @article = Article.find_by(code: params[:code])

      if @article.published?
        return redirect_to(@article.path)
      end

    else
      @article = Article.where(year:  params[:year]
                       ).where(month: params[:month]
                       ).where(day:   params[:day]
                       ).where(slug:  params[:slug]).first
    end

    # no articles found, go to /articles feed
    if @article.nil?
      return redirect_to articles_path
    else
      @title = @article.name
    end
  end
end
