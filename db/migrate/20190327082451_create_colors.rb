class CreateColors < ActiveRecord::Migration[5.2]
  def change
    create_table :colors do |t|
      t.string :name, null: false, index: { unique: true }
      t.string :code, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
