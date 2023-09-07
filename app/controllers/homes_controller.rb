class HomesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  def index
    page = (params[:page].presence || 1)
    limit = (params[:limit].presence || 5)
    @list_movies_of_users = Movie.list_movies_of_users.page(page).per(limit)
  end

  def share
    return render json: { status: 'failed', error: 'You do not have access' }, status: 500 if current_user.blank?

    movies = Movie.new(share_movies_params.merge!(user: current_user))
    if movies.save
      render json: { status: 'success', data: movies }, status: 200
    else
      render json: { status: 'failed', key: 'videoUrlError', error: movies.errors.full_messages.first }, status: :unprocessable_entity
    end
  rescue StandardError => e
    render json: { status: 'failed', error: e.message }, status: 500
  end

  private

  def share_movies_params
    params.fetch(:movies, {}).permit(:video_url)
  end
end
