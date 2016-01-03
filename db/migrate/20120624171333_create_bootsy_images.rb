class CreateBootsyImages < ActiveRecord::Migration
  def change
    create_table :bootsy_images do |t|
      t.string :image_file
      t.string :content_type
      t.references :image_gallery
      t.timestamps
    end
  end
end
