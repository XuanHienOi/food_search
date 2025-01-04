class CreateFoods < ActiveRecord::Migration[8.0]
  def change
    create_table :foods do |t|
      t.integer :restaurant_id
      t.integer :restaurant_item_id
      t.string :restaurant_name
      t.string :restaurant_address
      t.decimal :price, precision: 10, scale: 2
      t.decimal :old_price, precision: 10, scale: 2
      t.string :item_name
      t.text :item_details

      t.timestamps
    end

    add_index :foods, :restaurant_item_id, unique: true
    add_index :foods, :restaurant_id
  end
end
