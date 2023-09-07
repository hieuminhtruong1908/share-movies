require 'rails_helper'

RSpec.describe 'Registrations', type: :request do
  describe 'GET /users/sign_up' do
    it 'renders the signup template' do
      get '/users/sign_up'
      expect(response).to be_successful
      expect(response).to render_template('new')
    end
  end
end
