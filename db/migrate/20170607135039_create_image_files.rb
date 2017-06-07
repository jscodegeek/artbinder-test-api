class CreateImageFiles < ActiveRecord::Migration[5.1]
  def change
    create_table :image_files do |t|
      t.string :name
      t.string :path

      t.timestamps
    end
  end
end
