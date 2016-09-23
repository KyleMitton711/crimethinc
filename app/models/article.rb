class SlugValidator < ActiveModel::Validator
  def validate(record)
    if record.new_record? && record.slug_exists?
      record.errors[:slug] << "needs to be unique on the published date"
    end
  end
end

class Article < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :categorizations, dependent: :destroy
  has_many :categories, through: :categorizations

  default_scope { order("published_at DESC") }

  scope :on,      lambda { |date| where("published_at BETWEEN ? AND ?", date.try(:beginning_of_day), date.try(:end_of_day)) }
  scope :unpinned,    -> { where(pinned: false) }
  scope :pinned,      -> { where(pinned: true) }
  scope :page,        -> { where(page: true) }
  scope :feed,        -> { where(page: false) }

  scope :draft,       -> { where(status: "draft") }
  scope :edited,      -> { where(status: "edited") }
  scope :designed,    -> { where(status: "designed") }
  scope :published,   -> { where(status: "published") }

  before_validation :generate_slug,            on: [:create, :update]
  before_validation :generate_page_path,       on: [:create, :update]
  before_validation :generate_published_dates, on: [:create, :update]
  before_validation :generate_draft_code,      on: [:create, :update]
  validates_with SlugValidator

  def path
    if published?
      published_at.strftime("/%Y/%m/%d/#{slug}")
    else
      "/drafts/#{self.code}"
    end
  end

  def name
    if title.present? && subtitle.present?
      "#{title} : #{subtitle}"
    else
      title
    end
  end

  def slug_exists?
    Article.on(published_at).where(slug: slug).exists?
  end

  def save_tags!(tags_glob)
    self.taggings.destroy_all

    tags_glob.split(",").each do |name|
      unless name.blank?
        tag = Tag.find_or_create_by(name: name)
        self.tags << tag
      end
    end
  end

  def save_categories!(categories_glob)
    self.categorizations.destroy_all

    categories_glob.split(",").each do |name|
      unless name.blank?
        category = Category.find_or_create_by(name: name)
        self.categories << category
      end
    end
  end

  # article states through the process from creation to publishing
  def draft?
    status == "draft"
  end

  def edited?
    status == "edited"
  end

  def designed?
    status == "designed"
  end

  def published?
    status == "published"
  end

  def dated?
    published_at.present? &&
    published_at.year.present? &&
    published_at.month.present? &&
    published_at.day.present?
  end

  private

  def generate_slug
    if self.new_record? || self.slug_changed? || self.slug.blank?
      n = 0

      if slug.blank?
        self.slug = self.name.to_slug
      end

      while slug_exists?
        self.slug = name
        n += 1
        "#{self.slug} #{n}".to_slug
      end
    end

    self.slug = self.slug.to_slug
  end

  def generate_published_dates
    if published_at.present?
      self.year  = published_at.year                     if published_at.year.present?
      self.month = published_at.month.to_s.rjust(2, "0") if published_at.month.present?
      self.day   = published_at.day.to_s.rjust(2, "0")   if published_at.day.present?
    end
  end

  def generate_draft_code
    self.code ||= SecureRandom.hex
  end

  def generate_page_path
    if self.page_path.blank?
      self.page_path = self.slug
    end

    puts "in generate_page_path"
    path_pieces = self.page_path.split("/").reject{ |p| p.blank? }
    self.page_path = path_pieces.map{ |piece| piece.to_slug }.join("/")
    puts "self.page_path: #{self.page_path}"
    self.page_path
  end
end
