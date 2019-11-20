class RemoveScoreAndPiercedLevelFromTests < ActiveRecord::Migration[5.1]
  def change
    remove_column :tests, :score
    remove_column :tests, :pierced_level
  end
end
