class Physician < ApplicationRecord
  has_many :appointments
  has_many :patients, through: :appointments, class_name: 'Patient'
  has_many :appointment_infos, through: :appointments
end
