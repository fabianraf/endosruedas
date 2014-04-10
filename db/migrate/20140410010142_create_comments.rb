class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer "product_id"
      t.integer "user_id"
      t.text "comment"
      t.string "email"
      t.string "name"
      t.timestamps
    end
  end
end
