class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.text :comment
      t.integer :rating
      t.boolean :baby
      t.boolean :accessible
      t.boolean :sink
      t.boolean :soap
      t.boolean :paper
      t.boolean :tampon
      t.boolean :bin
      t.boolean :hanger
      t.boolean :spacious
      t.boolean :clean
      t.boolean :gendered
      t.boolean :privacy
      t.boolean :urinal
      t.boolean :towel
      t.boolean :gratis
      t.references :toilet, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
