class CreateSubmitQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :submit_questions do |t|
      t.integer :submit_id, null: false
      t.integer :question_id, null: false

      t.timestamps
    end
  end
end
