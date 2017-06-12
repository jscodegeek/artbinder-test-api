class CreateArtworks < ActiveRecord::Migration[5.1]
  def change
    create_table :artworks do |t|
      t.belongs_to :artist, index: true
      t.string :title
      t.string :description
      t.integer :price
      t.integer :width
      t.integer :height
      t.boolean :is_published

      t.timestamps
    end
  end
end
