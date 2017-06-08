class CreateImageFiles < ActiveRecord::Migration[5.1]
  def change
    create_table :image_files do |t|
      t.belongs_to :artwork, index: true
      t.string :name
      t.string :base64

      t.timestamps
    end
  end
end
