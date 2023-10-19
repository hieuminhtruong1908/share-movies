class CreateAppointmentInfo < ActiveRecord::Migration[7.0]
  def change
    create_table :appointment_infos do |t|
      t.integer :appointment_id
      t.string :description
      t.timestamps
    end
  end
end
