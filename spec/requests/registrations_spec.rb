require 'rails_helper'

RSpec.describe 'Registrations', type: :request do
  let!(:user) { build(:user) }
  describe 'GET /users/sign_up' do
    it 'renders signup template success' do
      get '/users/sign_up'
      expect(response).to be_successful
      expect(response).to render_template('new')
    end
  end

  describe 'POST /users' do
    context "when signup failed" do
      context "when email empty" do
        it 'return status 422 with error Email can not be blank' do
          post '/users', params: { user: { email: '', password: user.password, password_confirmation: user.password } }
          expect(response.status).to eq(422)
          expect(response.body).to include("Email can&#39;t be blank")
        end
      end

      context "when email invalid" do
        it 'return status 422 with error Email is invalid' do
          post '/users', params: { user: { email: 'hieutm', password: user.password } }
          expect(response.status).to eq(422)
          expect(response.body).to include("Email is invalid")
        end
      end

      context "when password empty" do
        it 'return status 422 with error Password can not be blank' do
          post '/users', params: { user: { email: user.email, password: '' } }
          expect(response.status).to eq(422)
          expect(response.body).to include("Password can&#39;t be blank")
        end
      end

      context "when password is too short" do
        it 'return status 422 with error Password is too short' do
          post '/users', params: { user: { email: user.email, password: '1234' } }
          expect(response.status).to eq(422)
          expect(response.body).to include("Password is too short (minimum is 6 characters)")
        end
      end

      context "when password is too long" do
        it 'return status 422 with error Password is too long' do
          post '/users', params: { user: { email: user.email, password: SecureRandom.hex(65) } }
          expect(response.status).to eq(422)
          expect(response.body).to include("Password is too long (maximum is 128 characters)")
        end
      end

      context "when password confirm not equal password" do
        it 'return status 422 with error Password confirmation dose not match Password' do
          post '/users',
               params: { user: { email: user.email, password: user.password, password_confirmation: 'asdasd121' } }
          expect(response.status).to eq(422)
          expect(response.body).to include("Password confirmation doesn&#39;t match Password")
        end
      end
    end

    context "when signup successfully" do
      it "success and return redirect to root_path" do
        post '/users',
             params: { user: { email: user.email, password: user.password, password_confirmation: user.password } }
        expect(response).to redirect_to(root_path)
      end
    end
  end

  after(:all) do
    User.delete_all
  end
end
