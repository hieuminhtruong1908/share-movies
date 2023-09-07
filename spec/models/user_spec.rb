require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  it 'is valid with valid attributes' do
    expect(user).to be_valid
  end

  it 'is not valid without an email empty' do
    user.email = nil
    expect(user).not_to be_valid
  end

  it 'is not valid without an email empty, text validate should equal to ' do
    user.email = nil
    expect(user.invalid?).to eq(true)
    expect(user.errors.full_messages.first).to eq("Email can't be blank")
  end

  it 'is not valid without an email empty, text validate should equal to Email can\'t be blank' do
    user.email = nil
    expect(user.invalid?).to eq(true)
    expect(user.errors.full_messages.first).to eq("Email can't be blank")
  end

  it 'is not valid with a valid email address' do
    user.email = 'hieutm'
    expect(user).not_to be_valid
  end

  it 'is not valid with a valid email address, text validate should equal to Email is invalid' do
    user.email = 'hieutm'
    email_regexp = /\A[^@\s]+@[^@\s]+\z/
    expect(user.email.match(email_regexp)).to be_nil
    expect(user.invalid?).to eq(true)
    expect(user.errors.full_messages.first).to eq('Email is invalid')
  end

  it 'is not valid with a duplicate email address' do
    user_create = create(:user)
    duplicate_user = FactoryBot.build(:user, email: user_create.email)
    expect(duplicate_user).not_to be_valid
    expect(duplicate_user.errors.full_messages.first).to eq('Email has already been taken')
  end

  it 'is not valid with a empty password' do
    user.password = ''
    expect(user).not_to be_valid
    expect(user.invalid?).to eq(true)
    expect(user.errors.full_messages.first).to eq('Password can\'t be blank')
  end

  it 'is not valid with a short password' do
    user.password = '12345'
    user.password_confirmation = '12345'
    expect(user).not_to be_valid
    expect(user.invalid?).to eq(true)
    expect(user.errors.full_messages.first).to eq('Password is too short (minimum is 6 characters)')
  end

  it 'is not valid with a long password' do
    user.password = SecureRandom.base64(129)
    user.password_confirmation = user.password
    expect(user).not_to be_valid
    expect(user.invalid?).to eq(true)
    expect(user.errors.full_messages.first).to eq('Password is too long (maximum is 128 characters)')
  end

  it 'is not valid without a password confirmation' do
    user.password_confirmation = ''
    expect(user).not_to be_valid
  end

  it 'is not valid without a password confirmation not equal password' do
    user.password = '123456'
    user.password_confirmation = '654321'
    expect(user.invalid?).to eq(true)
    expect(user).not_to be_valid
    expect(user.errors.full_messages.first).to eq("Password confirmation doesn't match Password")
  end

  after(:all) do
    User.delete_all
  end
end
