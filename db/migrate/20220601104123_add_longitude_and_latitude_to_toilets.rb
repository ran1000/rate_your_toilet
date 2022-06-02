class AddLongitudeAndLatitudeToToilets < ActiveRecord::Migration[7.0]
  def change
    add_column :toilets, :longitude, :float
    add_column :toilets, :latitude, :float
  end
end
