class Appointment < ApplicationRecord
  belongs_to :physician
  belongs_to :patient
  has_many :appointment_infos, dependent: :destroy
end
