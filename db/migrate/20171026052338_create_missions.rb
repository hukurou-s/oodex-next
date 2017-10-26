class CreateMissions < ActiveRecord::Migration[5.1]
  def change
    create_table :missions do |t|
      t.integer :session_id, null: false
      t.string :name, null: false
      t.text :detail, null: false

      t.timestamps
    end
  end
end
