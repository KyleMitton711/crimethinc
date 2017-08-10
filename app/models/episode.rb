class Episode < ApplicationRecord
  include Name

  belongs_to :podcast

  default_scope { order("id DESC") }

  after_create :generate_slug

  def path
    "/podcast/#{to_param}"
  end

  def to_param
    self.slug
  end

  def episode_id_in_podcast
    podcast.episodes.reverse.find_index(self) + 1
  end

  def generate_slug
    self.update slug: [podcast.episode_prefix, episode_id_in_podcast].reject(&:blank?).join("-")
  end

  def meta_description
    unless subtitle.blank? && content.blank?
      subtitle || content.truncate(200)
    end
  end

  def duration_string
    duration_in_seconds = duration.to_i.minutes

    hours   =  (duration_in_seconds / 3600).to_i
    minutes =  (duration_in_seconds / 60 - hours * 60).to_i
    seconds =  (duration_in_seconds - (minutes * 60 + hours * 3600)).to_i

    ['%.2d' % hours, '%.2d' % minutes, '%.2d' % seconds].join(":")
  end
end
