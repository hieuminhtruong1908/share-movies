class AddfieldToPictures < ActiveRecord::Migration[7.0]
  def change
    add_column :pictures, :movie_id, :integer
  end
end
