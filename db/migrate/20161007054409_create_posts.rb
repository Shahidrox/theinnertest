class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.integer  :count, default: 0, null: false

      t.timestamps null: false
    end
  end
end
