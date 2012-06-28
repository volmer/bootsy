# This migration comes from bootsy (originally 20120624171333)
class CreateBootsyImages < ActiveRecord::Migration
  def change
    create_table :bootsy_images do |t|
      t.string :image_file
      t.references :image_gallery
      t.timestamps
    end
  end
end
