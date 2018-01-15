class CreatePiercedLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :pierced_locations do |t|
      t.integer :mission_id, null: false
      t.string :file_name, null: false
      t.text :lines, null: false
      t.timestamps
    end
  end
end
