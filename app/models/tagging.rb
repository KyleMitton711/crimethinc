class Tagging < ApplicationRecord
  TAGGABLES = [
    ARTICLE   = "Article",
    PAGE      = "Page",
  ]

  belongs_to :tag
  belongs_to :taggable, polymorphic: true

  validates :tag, :taggable, presence: true
  validates :taggable_type, inclusion: { in: TAGGABLES }
end
