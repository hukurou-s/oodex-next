class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.integer :problem_id, null: false
      t.string :name, null: false
      t.text :detail, null: false

      t.timestamps
    end
  end
end
