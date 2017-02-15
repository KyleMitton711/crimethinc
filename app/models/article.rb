class Article < ApplicationRecord
  include Post

  belongs_to :theme

  has_many :taggings, dependent: :destroy, as: :taggable
  has_many :tags, through: :taggings
  has_many :categorizations, dependent: :destroy
  has_many :categories, through: :categorizations
  has_many :contributions, dependent: :destroy
  has_many :collection_posts, foreign_key: :collection_id, class_name: :Article
  belongs_to :collection, foreign_key: :parent_id, class_name: :Article

  accepts_nested_attributes_for :contributions, reject_if: :all_blank, allow_destroy: true

  scope :chronological, -> { order(published_at: :desc) }

  scope :root, -> { where(collection_id: nil) }

  before_validation :generate_slug,            on: [:create, :update]
  before_validation :generate_published_dates, on: [:create, :update]
  before_validation :downcase_content_format,  on: [:create, :update]

  default_scope { order("published_at DESC") }
  scope :live,     -> { where("published_at < ?", Time.now) }
  scope :on,       lambda { |date| where("published_at BETWEEN ? AND ?", date.try(:beginning_of_day), date.try(:end_of_day)) }
  scope :recent,   -> { where("published_at BETWEEN ? AND ?", Time.now - 2.days, Time.now) }
  scope :next,     lambda { |article| where("published_at > ?", article.published_at).live.published.order(published_at: :asc).limit(1) }
  scope :previous, lambda { |article| where("published_at < ?", article.published_at).live.published.chronological.limit(1) }

  def path
    if published?
      published_at.strftime("/%Y/%m/%d/#{slug}")
    else
      "/drafts/articles/#{self.draft_code}"
    end
  end

 # Overwrites slug_exists? from Slug.  We allow duplicate slugs on different
 # published_at dates.
  def slug_exists?
    Article.on(published_at).where(slug: slug).exists?
  end

  def collection_root?
    collection_posts.any?
  end

  def in_collection?
    # TODO this is a hack
    collection_id.present?
  end

  private

  def generate_published_dates
    if published_at.present?
      self.year  = published_at.year                     if published_at.year.present?
      self.month = published_at.month.to_s.rjust(2, "0") if published_at.month.present?
      self.day   = published_at.day.to_s.rjust(2, "0")   if published_at.day.present?
    end
  end

  def downcase_content_format
    self.content_format = self.content_format.downcase
  end
end
