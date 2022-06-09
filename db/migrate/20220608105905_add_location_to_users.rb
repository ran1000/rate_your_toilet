class AddLocationToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :lat, :float
    add_column :users, :lng, :float
  end
end
