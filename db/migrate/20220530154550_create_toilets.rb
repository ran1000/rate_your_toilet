class CreateToilets < ActiveRecord::Migration[7.0]
  def change
    create_table :toilets do |t|
      t.string :address
      t.string :name
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
