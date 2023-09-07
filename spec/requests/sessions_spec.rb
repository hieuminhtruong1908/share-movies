require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  describe 'GET /users/sign_in' do
    it 'renders the login template' do
      get '/users/sign_in'
      expect(response).to be_successful
      expect(response).to render_template('new')
    end
  end

  describe 'POST /users/sign_in' do
    let(:user) { create(:user) }
    it 'redirects to the home movies on login success' do
      post user_session_path,
           params: { user: { email: user.email, password: user.password } }
      expect(response).to redirect_to(root_path)
    end

    it 'login failed with empty email' do
      post user_session_path,
           params: { user: { email: '', password: user.password } }
      expect(response.status).to eq(422)
      expect(response).to render_template('new')
      expect(response.body).to include('Invalid Email or password.')
    end

    it 'login failed with not correct email' do
      post user_session_path,
           params: { user: { email: 'abc@gmail.com', password: user.password } }
      expect(response.status).to eq(422)
      expect(response).to render_template('new')
      expect(response.body).to include('Invalid Email or password.')
    end

    it 'login failed with empty password' do
      post user_session_path,
           params: { user: { email: 'abc@gmail.com', password: '' } }
      expect(response.status).to eq(422)
      expect(response).to render_template('new')
      expect(response.body).to include('Invalid Email or password.')
    end

    it 'login failed not correct password' do
      post user_session_path, params: { user: { email: user.email, password: '99999' } }
      expect(response.status).to eq(422)
      expect(response).to render_template('new')
      expect(response.body).to include('Invalid Email or password.')
    end
  end
end
