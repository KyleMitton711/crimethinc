module Admin
  class LogosController < Admin::AdminController
    before_action :authorize
    before_action :set_logo,     only: [:show, :edit, :update, :destroy]
    before_action :set_statuses, only: [:new, :edit]

    def index
      @logos = Logo.order(slug: :asc).page(params[:page])
      @title = admin_title
    end

    def show
      @title = admin_title(@logo, [:title, :subtitle])
    end

    def new
      @logo = Logo.new
      @title = admin_title
      @logo.status = Status.find_by(name: 'draft')
    end

    def edit
      @title = admin_title(@logo, [:id, :title, :subtitle])
    end

    def create
      @logo = Logo.new(logo_params)

      if @logo.save
        redirect_to [:admin, @logo], notice: 'Logo was successfully created.'
      else
        set_statuses
        render :new
      end
    end

    def update
      if @logo.update(logo_params)
        redirect_to [:admin, @logo], notice: 'Logo was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @logo.destroy
      redirect_to [:admin, :logos], notice: 'Logo was successfully destroyed.'
    end

    private

    def set_logo
      @logo = Logo.find(params[:id])
    end

    def set_statuses
      @draft     = Status.find_by(name: 'draft')
      @published = Status.find_by(name: 'published')
    end

    def logo_params
      params.require(:logo).permit(:title, :subtitle, :description,
                                   :slug, :height, :width, :content_format, :summary, :status_id, :published_at,
                                   :jpg_url_present, :png_url_present, :pdf_url_present, :svg_url_present, :tif_url_present)
    end
  end
end
