class CreateTests < ActiveRecord::Migration[5.1]
  def change
    create_table :tests do |t|
      t.integer :mission_id, null: false
      t.string :test_name, null: false
      t.string :test_command, null: false
      t.integer :pierced_location_id, null: false
      t.integer :score, null: false, default: 50
      t.integer :pierced_level, null: false, default: 0

      t.timestamps
    end
  end
end
