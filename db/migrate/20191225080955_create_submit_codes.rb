class CreateSubmitCodes < ActiveRecord::Migration[5.1]
  def change
    create_table :submit_codes do |t|
      t.integer :submit_id, null: false
      t.string :file_name, null: false
      t.text :code, null: false
      t.integer :pierced_location_id, null: false

      t.timestamps
    end
  end
end
