class AddDistanceToToilets < ActiveRecord::Migration[7.0]
  def change
    add_column :toilets, :toilet_distance, :float
  end
end
