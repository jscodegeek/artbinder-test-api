class CreateArtworks < ActiveRecord::Migration[5.1]
  def change
    create_table :artworks do |t|
      t.string :title
      t.string :description
      t.integer :price
      t.integer :width
      t.integer :height
      t.string :status
      t.string :images

      t.timestamps
    end
  end
end
