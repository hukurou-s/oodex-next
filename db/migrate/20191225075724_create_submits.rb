class CreateSubmits < ActiveRecord::Migration[5.1]
  def change
    create_table :submits do |t|
      t.integer :user_id, null: false
      t.integer :mission_id, null: false

      t.timestamps
    end
  end
end
