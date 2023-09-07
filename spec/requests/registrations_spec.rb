require 'rails_helper'

RSpec.describe 'Registrations', type: :request do
  let(:user) { build(:user) }
  describe 'GET /users/sign_up' do
    it 'renders the signup template' do
      get '/users/sign_up'
      expect(response).to be_successful
      expect(response).to render_template('new')
    end
  end

  describe 'POST /users' do
    it 'signup failed with empty email' do
      post '/users', params: { user: { email: '', password: user.password, password_confirmation: user.password } }
      expect(response.status).to eq(422)
      expect(response).to render_template('new')
      expect(response.body).to include("Email can&#39;t be blank")
    end

    it 'signup failed with invalid regex email' do
      post '/users', params: { user: { email: 'hieutm', password: user.password } }
      expect(response.status).to eq(422)
      expect(response).to render_template('new')
      expect(response.body).to include("Email is invalid")
    end

    it 'signup failed with empty password' do
      post '/users', params: { user: { email: user.email, password: '' } }
      expect(response.status).to eq(422)
      expect(response).to render_template('new')
      expect(response.body).to include("Password can&#39;t be blank")
    end

    it 'signup failed with invalid password is short' do
      post '/users', params: { user: { email: user.email, password: '1234' } }
      expect(response.status).to eq(422)
      expect(response).to render_template('new')
      expect(response.body).to include("Password is too short (minimum is 6 characters)")
    end

    it 'signup failed with invalid password is long' do
      post '/users', params: { user: { email: user.email, password: SecureRandom.base64(129) } }
      expect(response.status).to eq(422)
      expect(response).to render_template('new')
      expect(response.body).to include("Password is too long (maximum is 128 characters)")
    end

    it 'signup failed with  password confirm not equal password' do
      post '/users',
           params: { user: { email: user.email, password: user.password, password_confirmation: 'asdasd121' } }
      expect(response.status).to eq(422)
      expect(response).to render_template('new')
      expect(response.body).to include("Password confirmation doesn&#39;t match Password")
    end

    it 'signup successfully' do
      post '/users',
           params: { user: { email: user.email, password: user.password, password_confirmation: user.password } }
      expect(response.status).to eq(303)
      expect(response).to redirect_to(root_path)
    end
  end

  after(:all) do
    User.delete_all
  end
end
