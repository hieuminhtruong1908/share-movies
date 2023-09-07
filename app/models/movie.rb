class Movie < ApplicationRecord
  YOUTUBE_URL_REGEX = %r{\A.*((youtu.be/)|(v/)|(/u/\w/)|(embed/)|(watch\?))\??v?=?([^#&?]*).*\z}

  belongs_to :user, optional: true, touch: true, inverse_of: :movies

  validates :user_id, presence: true

  validates :video_url, presence: true, format:
    { with: YOUTUBE_URL_REGEX,
      message: 'Vui lòng nhập Youtube URL đúng định dạng',
      if: -> { video_url.present? } }

  scope :list_movies_of_users, -> { select(:user_id, :video_url, :updated_at).includes(:user).order(updated_at: :desc) }
end
