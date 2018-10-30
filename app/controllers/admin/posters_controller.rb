module Admin
  class PostersController < Admin::AdminController
    before_action :authorize
    before_action :set_poster,           only: [:show, :edit, :update, :destroy]
    before_action :set_publication_type, only: [:show, :edit, :new, :index]
    before_action :set_statuses,         only: [:new, :edit]

    def index
      @posters = Poster.poster.order(slug: :asc).page(params[:page]).per(50)
      @title = admin_title
    end

    def show
      return redirect_to([nil, 'admin', 'stickers', @poster.id].join('/')) if @poster.sticker?

      @title = admin_title(@poster, [:title, :subtitle])
    end

    def new
      @poster = Poster.new
      @poster.status = Status.find_by(name: 'draft')
      @title = admin_title
    end

    def edit
      return redirect_to([nil, 'admin', 'stickers', @poster.id, 'edit'].join('/')) if @poster.sticker?

      @title = admin_title(@poster, [:id, :title, :subtitle])
    end

    def create
      @poster = Poster.new(poster_params)
      publication_type = @poster.sticker? ? :stickers : :posters

      if @poster.save
        redirect_to [:admin, @poster], notice: "#{publication_type.to_s.capitalize.singularize} was successfully created."
      else
        set_statuses
        render :new
      end
    end

    def update
      publication_type = @poster.sticker? ? :stickers : :posters
      if @poster.update(poster_params)
        redirect_to [:admin, @poster], notice: "#{publication_type.to_s.capitalize.singularize} was successfully updated."
      else
        render :edit
      end
    end

    def destroy
      publication_type = @poster.sticker? ? :stickers : :posters
      @poster.destroy
      redirect_to [:admin, publication_type], notice: "#{publication_type.to_s.capitalize.singularize} was successfully destroyed."
    end

    private

    def set_poster
      @poster = Poster.find(params[:id])
    end

    def set_publication_type
      @publication_type = 'poster'
    end

    def set_statuses
      @draft     = Status.find_by(name: 'draft')
      @published = Status.find_by(name: 'published')
    end

    def poster_params
      params.require(:poster).permit(:sticker, :title, :subtitle, :content, :content_format,
                                     :buy_info, :buy_url, :price_in_cents, :summary, :description, :published_at, :status_id,
                                     :front_image_present, :back_image_present, :front_download_present, :back_download_present,
                                     :slug, :height, :width, :depth, :front_image_format, :back_image_format,
                                     :front_color_image_present, :front_black_and_white_image_present, :back_color_image_present,
                                     :back_black_and_white_image_present, :front_color_download_present,
                                     :front_black_and_white_download_present, :back_color_download_present,
                                     :back_black_and_white_download_present)
    end
  end
end
