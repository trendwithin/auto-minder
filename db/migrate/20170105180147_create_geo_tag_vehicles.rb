class CreateGeoTagVehicles < ActiveRecord::Migration[5.0]
  def change
    create_table :geo_tag_vehicles do |t|
      t.string :make
      t.string :model
      t.string :color
      t.string :license_plate, null: false
      t.string :latitude, null: false
      t.string :longitude, null: false
      t.text :additional_info

      t.timestamps
    end
  end
end
