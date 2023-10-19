class Picture < ApplicationRecord
  belongs_to :movie
  belongs_to :owner, polymorphic: true
end
