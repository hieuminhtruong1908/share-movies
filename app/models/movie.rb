class Movie < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id', optional: true, touch: true

  YOUTUBE_URL_REGEX = %r{\A.*((youtu.be/)|(v/)|(/u/\w/)|(embed/)|(watch\?))\??v?=?([^#&?]*).*\z}.freeze


  validates :video_url, presence: true, format:
    { with: YOUTUBE_URL_REGEX,
      message: 'Vui lòng nhập Youtube URL đúng định dạng',
      if: -> { video_url.present? }
    }

  scope :list_movies_of_users, -> { select(:user_id, :video_url, :updated_at).includes(:user) }
end
