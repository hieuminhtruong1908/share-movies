require 'rails_helper'

RSpec.describe "Homes", type: :request do
  describe "GET /index" do
    it 'renders the home movie' do
      get '/'
      expect(response).to be_successful
      expect(response).to render_template('index')
    end

    it 'should list all movies' do
      user = create(:user)
      movie = create(
        :movie,
        video_url: 'https://www.youtube.com/watch?v=-eAU7uDq6pU',
        user:
      )

      p movie
      movie1 = create(
        :movie,
        video_url: 'https://www.youtube.com/watch?v=YsF5AfA39K0',
        user:
      )
      p movie1
      get '/'
      expect(response).to be_successful
      expect(response).to render_template('index')
      expect(assigns(:list_movies_of_users)).to be_present
    end

    it 'has no movies' do
      Movie.delete_all
      get '/'
      expect(response).to be_successful
      expect(response).to render_template('index')
      expect(assigns(:list_movies_of_users)).not_to be_present
    end
  end

  describe "POST /share" do
    it 'should not share movie when user not login' do
      post '/movies/share', params: {
        movies: {
          video_url: 'https://www.youtube.com/watch?v=OGSRrZROvlo'
        }
      }
      expect(response.status).to eq(302)
      expect(response).to redirect_to('/users/sign_in')
    end

    it 'should not share movie when video_url is empty' do
      user = create(:user)
      login_as(user)

      post '/movies/share', params: {
        movies: {
          video_url: ''
        }
      }
      expect(response.status).to eq(422)
      expect(JSON.parse(response.body)['error']).to eq("Video url can't be blank")
    end

    it 'should not share movie when video_url is not valid' do
      user = create(:user)
      login_as(user)

      post '/movies/share', params: {
        movies: {
          video_url: 'https://facebook.com'
        }
      }
      expect(response.status).to eq(422)
      expect(JSON.parse(response.body)['error']).to eq("Video url Vui lòng nhập Youtube URL đúng định dạng")
    end

    it 'share movie successfully' do
      user = create(:user)
      login_as(user)

      post '/movies/share', params: {
        movies: {
          video_url: 'https://www.youtube.com/watch?v=tgbNymZ7vqY'
        }
      }
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)['status']).to eq("success")
    end
  end

  before do
    ActionController::Base.allow_forgery_protection = false
  end

  after(:all) do
    User.delete_all
  end
end
