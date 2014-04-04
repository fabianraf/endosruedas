class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string   "file"
      t.integer  "bicycle_id"
      t.integer  "motorcycle_id"
      t.string   "group"
      t.timestamps
    end
  end
end
