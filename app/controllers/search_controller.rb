class SearchController < ApplicationController
  def index
    @html_id = 'page'
    @body_id = 'search'

    return redirect_to root_path if params[:q].blank?

    @search  = Search.new(search_params)
    @results = @search.perform.page(params[:page]).per(15)
    @title   = title_for :search, :results, "“#{@search.query}”"
  end

  def advanced
    @html_id = 'page'
    @body_id = 'search'
    @title   = title_for :search, :advanced

    @advanced_search = AdvancedSearch.new(params[:q])
  end

  def advanced_search
    @advanced_search = AdvancedSearch.new
    @advanced_search.update(params[:advanced_search])

    redirect_to(search_path(q: @advanced_search.query))
  end

  private

  def search_params
    # single quotes are part of postgres’s plain text search syntax
    # and need to be removed to prevent syntax errors.
    #
    # There may be a way to handle single quotes in search terms that
    # doesn’t cause database-level concerns up to the controller
    # level, but I didn't find any (see commit message for links)
    params[:q].tr("'", '')
  end
end
