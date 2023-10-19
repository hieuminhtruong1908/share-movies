class Employee < ApplicationRecord
  has_many :pictures, as: :owner, depend_on: :destroy
end
