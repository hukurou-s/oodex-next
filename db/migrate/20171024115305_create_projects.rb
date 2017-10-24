class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.integer :session_id, null: false
      t.string :name, null: false
      t.text :detail, null: false

      t.timestamps
    end

    add_index :projects, :session_id
  end
end
