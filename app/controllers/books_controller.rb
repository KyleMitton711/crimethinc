class BooksController < ApplicationController
  before_action :set_book, only: [:show, :extras]

  def index
    @html_id = "page"
    @body_id = "books"
    @title   = "Books"

    @bullet_books = []
    %w(from-democracy-to-freedom
       contradictionary
       work
       expect-resistance
       days-of-war-nights-of-love
       recipes-for-disaster
       no-wall-they-can-build).each do |slug|
      @bullet_books << Book.find_by(slug: slug)
    end

    @letters_books = []
    %w(off-the-map).each do |slug|
      @letters_books << Book.find_by(slug: slug)
    end
  end

  def show
    @html_id = "page"
    @body_id = "books"
    @title   = "Books : #{@book.title}"
  end

  def extras
    @html_id = "page"
    @body_id = "books"
    @title   = "Books : #{@book.title} : Extras"
  end

  def lit_kit
    @html_id = "page"
    @body_id = "books"
    @title   = "Books : Literature Distribution Kit"
  end

  def into_libraries
    @html_id = "page"
    @body_id = "books"
    @title   = "Books : CrimethInc. Into Libraries"
  end

  private

  def set_book
    @book = Book.find_by(slug: params[:slug])
  end
end
