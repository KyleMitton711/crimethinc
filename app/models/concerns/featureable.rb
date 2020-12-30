module Featureable
  extend ActiveSupport::Concern

  included do
    scope :featured, -> { where.not(featured_at: nil) }
    before_save :update_featured_at
  end

  module ClassMethods
    def for_index fallback_sort = { title: :asc }
      where.not(hide_from_index: true).reorder(position: :asc).order(fallback_sort).english.published.live
    end
  end

  def update_featured_at
    self.featured_at = featured_status? ? Time.current : nil
  end
end
