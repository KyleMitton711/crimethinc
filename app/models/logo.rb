class Logo < ApplicationRecord
  include Tool
  has_one_attached :image_jpg, dependent: :destroy
  has_one_attached :image_png, dependent: :destroy
  has_one_attached :image_pdf, dependent: :destroy
  has_one_attached :image_svg, dependent: :destroy
  has_one_attached :image_tif, dependent: :destroy

  IMAGE_FORMATS = %i[jpg png tif svg pdf].freeze

  class << self
    def image_formats
      IMAGE_FORMATS
    end
  end

  def front_image
    Rails.application.routes.url_helpers.rails_blob_path image_jpg, only_path: true
  end

  # TODO: delete on 2020-08-15 if unused until then
  def image_url _
    puts "#{'*' * 80} Logo#image_url used by #{caller} #{'*' * 80}"

    Rails.application.routes.url_helpers.rails_blob_url image_jpg
  end

  def meta_description
    "CrimethInc. logo: #{title}"
  end

  def meta_image
    Rails.application.routes.url_helpers.rails_blob_url image_jpg
  end

  def back_download_present?; end

  def back_image_present?; end

  def buy_info; end

  def content; end

  def depth; end

  def front_download_present?; end

  def price_in_cents; end
end
