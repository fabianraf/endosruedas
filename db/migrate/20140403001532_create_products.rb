class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string "title"
      t.boolean "new"
      t.integer "status"
      t.string "type"
      t.integer "brand_id"
      t.integer "model_id"
      t.integer "year"
      t.string "city"
      t.string "brake"
      t.integer "size_id"
      t.integer "speed_id"
      t.decimal "amount", :precision => 9, :scale => 2
      t.text "description"
      t.float "mileage"
      t.float "cylinder_capacity"
      t.string "color"
      t.integer "fuel_id"
      t.timestamps
    end
  end
end
