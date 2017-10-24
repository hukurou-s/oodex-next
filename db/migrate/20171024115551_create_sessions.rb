class CreateSessions < ActiveRecord::Migration[5.1]
  def change
    create_table :sessions do |t|
      t.string :name, null: false
      t.text :detail, null: false

      t.timestamps
    end
  end
end
