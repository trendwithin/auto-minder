class AddStateAndUserIdToGeoTagVehicles < ActiveRecord::Migration[5.0]
  def change
    add_column :geo_tag_vehicles, :state, :string, null: false
    add_column :geo_tag_vehicles, :user_id, :integer, null: false
  end
end
