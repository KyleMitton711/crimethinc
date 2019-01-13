class JournalsController < ApplicationController
  def index
    @html_id = 'page'
    @body_id = 'tools'
    @type    = 'journals'
    @title   = title_for :journals

    journals = Journal.order(published_at: :desc).live.published

    @featured_tools = journals.where.not(buy_url: nil)
    @tools          = journals.where(buy_url: nil)

    render 'tools/index'
  end

  def show
    # Treat a Zine as a Book
    @book = Journal.live.published.where(slug: params[:slug]).first
    return redirect_to [:journals] if @book.blank?

    @html_id = 'page'
    @body_id = 'tools'
    @type    = 'journals'

    @title    = title_for :journals, @book.name
    @editable = @book

    # Use the Book view
    render 'books/show'
  end
end
