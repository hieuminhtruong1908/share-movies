class HomesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [:index]
  def index
    page = (params[:page].presence || 1)
    limit = (params[:limit].presence || 5)
    @list_movies_of_users = Movie.list_movies_of_users.page(page).per(limit)
    TestJob.perform_later
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

  def product_index
    @products = Product.all
    @product = Product.new
    filename = @products.last.avatars.first.filename
    Rails.logger.info "filename: #{filename}"
    # send_data  @products.last.avatars.first.download, disposition: 'attachment', filename: filename.to_s
  end

  def product_create
    product = Product.new product_params
    product.save
  end

  def product_show
    @product = Product.last
  end

  def product_update
    @product = Product.find_by(id: params[:product][:id])
    @product.update(product_params)
  end


  private

  def share_movies_params
    params.fetch(:movies, {}).permit(:video_url)
  end

  def product_params
    params.require(:product).permit(:avatars => [])
  end
end
