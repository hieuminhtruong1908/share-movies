require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user_create) { build(:user) }
  let(:movie) {build(:movie, user: user_create)}


  it 'is not valid with a nil video url' do
    movie.video_url = ''
    expect(movie).not_to be_valid
  end

  it 'is not valid with a not regex video youtube url' do
    movie.video_url = 'https://facebook.com'
    expect(movie).not_to be_valid
  end

  it 'is valid movie' do
    movie.video_url = 'https://www.youtube.com/watch?v=vQQKIyAHPI4&list=PLS6F722u-R6Ik3fbeLXbSclWkT6Qsp9ng&index=2&pp=iAQB'
    expect(movie).to be_valid
  end

  after(:all) do
    User.delete_all
  end
end