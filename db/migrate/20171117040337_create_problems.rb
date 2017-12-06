class CreateProblems < ActiveRecord::Migration[5.1]
  def change
    create_table :problems do |t|
      t.integer :mission_id, null: false
      t.string :name, null: false
      t.text :detail, null: false

      t.timestamps
    end
  end
end
