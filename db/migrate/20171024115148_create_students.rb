class CreateStudents < ActiveRecord::Migration[5.1]
  def change
    create_table :students do |t|
      t.string :display_name, null: false
      t.integer :user_id, null: false
      t.integer :team_id, null: false
      t.integer :session_id, null: false

      t.timestamps
    end
  end
end
