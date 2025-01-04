class CreateVendors < ActiveRecord::Migration[8.0]
  def change
    create_table :vendors do |t|
      t.integer :classify
      t.integer :restaurant_id
      t.string :name
      t.float :rating
      t.float :latitude
      t.float :longitude
      t.string :display_address
      t.string :address
      t.integer :city

      t.timestamps
    end
  end
end
