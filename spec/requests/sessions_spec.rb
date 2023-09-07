require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  describe 'GET /users/sign_in' do
    context "when render view sign_in success" do
      it 'return success' do
        get '/users/sign_in'
        expect(response).to be_successful
      end
    end
  end

  describe 'POST /users/sign_in' do
    let(:user) { create(:user) }
    context "when login success" do
      it "redirects to the home" do
        post user_session_path,
             params: { user: { email: user.email, password: user.password } }
        expect(response).to redirect_to(root_path)
      end
    end

    context "when login failed" do
      context "when empty email" do
        it "return status 422 and error Invalid Email or password." do
          post user_session_path,
               params: { user: { email: '', password: user.password } }
          expect(response.status).to eq(422)
          expect(response.body).to include('Invalid Email or password.')
        end
      end

      context "when email is invalid" do
        it "return status 422 and error Invalid Email or password." do
          post user_session_path,
               params: { user: { email: 'abcd', password: user.password } }
          expect(response.status).to eq(422)
          expect(response.body).to include('Invalid Email or password.')
        end
      end

      context "when email is not correct" do
        it "return status 422 and error Invalid Email or password." do
          post user_session_path,
               params: { user: { email: 'hiu@gmail.com', password: user.password } }
          expect(response.status).to eq(422)
          expect(response.body).to include('Invalid Email or password.')
        end
      end

      context "when empty password" do
        it "return status 422 and error Invalid Email or password." do
          post user_session_path,
               params: { user: { email: 'abc@gmail.com', password: '' } }
          expect(response.status).to eq(422)
          expect(response.body).to include('Invalid Email or password.')
        end
      end

      context "when password is not correct" do
        it "return status 422 and error Invalid Email or password." do
          post user_session_path,
               params: { user: { email: user.email, password: 'Abcd12355' } }
          expect(response.status).to eq(422)
          expect(response.body).to include('Invalid Email or password.')
        end
      end
    end
  end
end
