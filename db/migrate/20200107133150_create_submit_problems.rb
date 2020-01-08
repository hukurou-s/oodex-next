class CreateSubmitProblems < ActiveRecord::Migration[5.1]
  def change
    create_table :submit_problems do |t|
      t.integer :submit_id, null: false
      t.integer :problem_id, null: false

      t.timestamps
    end
  end
end
