class CreateTagMyVehicles < ActiveRecord::Migration[5.0]
  def change
    create_table :tag_my_vehicles do |t|
      t.references :user,  foreign_key: true
      t.string :latitude,  null: false
      t.string :longitude, null: false

      t.timestamps
    end
  end
end
