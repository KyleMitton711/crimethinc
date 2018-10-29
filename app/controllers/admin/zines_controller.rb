module Admin
  class ZinesController < Admin::AdminController
    before_action :authorize
    before_action :set_zine,             only: [:show, :edit, :update, :destroy]
    before_action :set_publication_type, only: [:show, :edit, :new, :index]
    before_action :set_ebook_formats,    only: [:edit, :new]
    before_action :set_statuses,         only: [:new, :edit]

    def index
      @books = Book.zine.order(slug: :asc).page(params[:page])
      @title = admin_title
      render 'admin/books/index'
    end

    def show
      return redirect_to([nil, 'admin', 'books', @book.id].join('/')) if @book.book?

      @title = admin_title(@book, [:title, :subtitle])
      render 'admin/books/show'
    end

    def new
      @book = Book.new(zine: true)
      @title = admin_title
      @book.status = Status.find_by(name: 'draft')

      render 'admin/books/new'
    end

    def edit
      return redirect_to([nil, 'admin', 'books', @book.id, 'edit'].join('/')) if @book.book?

      @title = admin_title(@book, [:id, :title, :subtitle])
      render 'admin/books/edit'
    end

    def create
      @book      = Book.new(book_params)
      @book.zine = true

      if @book.save
        redirect_to [:admin, @book], notice: 'Zine was successfully created.'
      else
        set_statuses
        render :new
      end
    end

    def update
      if @book.update(book_params)
        redirect_to [:admin, @book], notice: 'Zine was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      # Handled by admin/books#destroy
    end

    private

    def set_zine
      @book = Book.find(params[:id])
    end

    def set_statuses
      @draft     = Status.find_by(name: 'draft')
      @published = Status.find_by(name: 'published')
    end

    def set_publication_type
      @publication_type = 'zine'
    end

    def set_ebook_formats
      @ebook_formats = Tool::EBOOK_FORMATS
    end

    def book_params
      params.require(:book).permit(:title, :subtitle, :content, :tweet, :summary, :status_id,
                                   :description, :buy_url, :buy_info, :content_format, :slug, :series, :published_at,
                                   :price_in_cents, :height, :width, :depth, :weight, :pages, :words, :illustrations,
                                   :photographs, :printing, :ink, :definitions, :recipes, :has_index, :cover_style,
                                   :binding_style, :table_of_contents, :zine, :back_image_present,
                                   :lite_download_present, :epub_download_present, :mobi_download_present,
                                   :print_black_and_white_a4_download_present, :print_color_a4_download_present,
                                   :print_color_download_present, :print_black_and_white_download_present,
                                   :screen_single_page_view_download_present, :screen_two_page_view_download_present)
    end
  end
end
