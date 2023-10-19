class Product < ApplicationRecord
  has_many :pictures, as: :owner, dependent: :destroy
  has_many_attached :avatars
end
