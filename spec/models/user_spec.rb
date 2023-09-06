require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) } # Sử dụng Factory Bot để tạo một đối tượng User

  it 'is valid with valid attributes' do
    expect(user).to be_valid
  end

  it 'is not valid without an email' do
    user.email = nil
    expect(user).not_to be_valid
  end


  it 'is not valid with a valid email address' do
    user.email = 'hieutm'
    expect(user).not_to be_valid
  end


  it 'is not valid with a duplicate email address' do
    user_create = create(:user)
    duplicate_user = FactoryBot.build(:user, email: user_create.email)
    expect(duplicate_user).not_to be_valid
  end

  it 'is not valid with a empty password' do
    user.password = ''
    expect(user).not_to be_valid
  end


  it 'is not valid with a short password' do
    user.password = '12345'
    expect(user).not_to be_valid
  end

  it 'is not valid with a long password' do
    user.password = SecureRandom.base64(129)
    expect(user).not_to be_valid
  end

  it 'is not valid without a password confirmation' do
    user.password_confirmation = ''
    expect(user).not_to be_valid
  end

  it 'is not valid without a password confirmation not equal pasword' do
    user.password = '123456'
    user.password_confirmation = '654321'
    expect(user).not_to be_valid
  end
  

  after(:all) do
    User.delete_all
  end
end