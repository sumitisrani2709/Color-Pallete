class CreatePaletteColor < ActiveRecord::Migration[5.2]
  def change
    create_table :palette_colors do |t|
      t.belongs_to :palette, index: true
      t.belongs_to :color, index: true

      t.timestamps
    end
  end
end
