class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.integer :deep, null: false, default: 10
      t.text :body, null: false
      t.integer :user_id, null: false
      t.string :keyword, null: false
      t.string :children_keyword, null: false

      t.timestamps null: false
    end
  end
end
