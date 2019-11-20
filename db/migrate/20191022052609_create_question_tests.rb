class CreateQuestionTests < ActiveRecord::Migration[5.1]
  def change
    create_table :question_tests do |t|
      t.integer :question_id, null: false
      t.integer :test_id, null: false
      t.integer :score, null: false, default: 50
      t.integer :pierced_level, null: false, default: 0

      t.timestamps
    end
  end
end
