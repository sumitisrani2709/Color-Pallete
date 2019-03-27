class AddSlugToPalettes < ActiveRecord::Migration[5.2]
  def change
    add_column :palettes, :slug, :string
    add_index :palettes, :slug, unique: true
  end
end
