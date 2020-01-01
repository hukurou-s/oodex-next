class CreateTestResults < ActiveRecord::Migration[5.1]
  def change
    create_table :test_results do |t|
      t.integer :submit_id, null: false
      t.integer :test_id, null: false
      t.string :status, null: false
      t.string :target, null: false
      t.text :message, null: false

      t.timestamps
    end
  end
end
