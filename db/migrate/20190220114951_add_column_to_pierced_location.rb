class AddColumnToPiercedLocation < ActiveRecord::Migration[5.1]
  def change
    add_column :pierced_locations, :location_id, :integer, null: false
  end
end
