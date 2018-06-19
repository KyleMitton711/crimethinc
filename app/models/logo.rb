class Logo < ApplicationRecord
  include Name
  include Slug
  include Publishable

  default_scope { order(published_at: :desc) }

  ASSET_BASE_URL = 'https://cloudfront.crimethinc.com/assets'.freeze
  FORMATS = %w[jpg png pdf svg tif].freeze

  def namespace
    'logos'
  end

  def path
    [nil, namespace, slug].join('/')
  end

  def image_description
    "Photo of ‘#{title}’ logo"
  end
  alias front_image_description image_description

  def preview_image_url
    [ASSET_BASE_URL, namespace, slug, 'preview.png'].join('/')
  end
  alias front_image preview_image_url

  def image_url(extension)
    filename = [slug, '.', extension.to_s].join
    [ASSET_BASE_URL, namespace, slug, filename].join('/')
  end
  alias download_url image_url

  def meta_description
    "CrimethInc. logo: #{title}. Size: #{width} x #{height}."
  end

  def meta_image
    image_url :png
  end
  alias image meta_image

  def price_in_cents
    nil
  end

  def buy_info
    nil
  end

  def back_image_present?
    nil
  end

  def front_download_present?
    nil
  end

  def back_download_present?
    nil
  end

  def depth
    nil
  end

  def content
    nil
  end
end
