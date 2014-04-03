class CreateProducts < ActiveRecord::Migration
  def change
    'is_new','status', 'type', 'brand', 'model', 'year', 'city', 'brake','size', 'speed','amount', 'description'
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
      t.timestamps
    end
  end
end
