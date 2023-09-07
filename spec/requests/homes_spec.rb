require 'rails_helper'

RSpec.describe "Homes", type: :request do
  before do
    ActionController::Base.allow_forgery_protection = false
  end

  describe "GET /index" do
    let!(:movie) do
      create(
        :movie,
        video_url: 'https://www.youtube.com/watch?v=-eAU7uDq6pU'
      )
    end

    context "when view index render successfully" do
      it 'return success' do
        get '/'
        expect(response).to be_successful
      end

      context "when has movie" do
        it 'Has present data' do
          get '/'
          expect(assigns(:list_movies_of_users)).to be_present
        end
        it 'No present data' do
          get '/'
          expect(assigns(:list_movies_of_users)).to be_present
        end
      end
    end
  end

  describe "POST /share" do
    context "when user login" do
      let(:user) { create(:user) }

      before do
        login_as(user)
      end

      context "when video_url is empty" do
        it 'should not share movie' do
          post '/movies/share', params: {
            movies: {
              video_url: ''
            }
          }
          expect(response.status).to eq(422)
          expect(JSON.parse(response.body)['error']).to eq("Video url can't be blank")
        end
      end

      context "when video_url is invalid" do
        it 'should not share movie' do
          post '/movies/share', params: {
            movies: {
              video_url: 'https://facebook.com'
            }
          }
          expect(response.status).to eq(422)
          expect(JSON.parse(response.body)['error']).to eq("Video url Vui lòng nhập Youtube URL đúng định dạng")
        end
      end

      context "when video_url valid" do
        it 'share movie successfully' do
          post '/movies/share', params: {
            movies: {
              video_url: 'https://www.youtube.com/watch?v=tgbNymZ7vqY'
            }
          }
          expect(response.status).to eq(200)
          expect(JSON.parse(response.body)['status']).to eq("success")
        end
      end
    end

    context "when user not login" do
      it 'should not share movie' do
        post '/movies/share', params: {
          movies: {
            video_url: 'https://www.youtube.com/watch?v=OGSRrZROvlo'
          }
        }
        expect(response.status).to eq(302)
        expect(response).to redirect_to('/users/sign_in')
      end
    end
  end

  after(:all) do
    User.delete_all
  end
end
