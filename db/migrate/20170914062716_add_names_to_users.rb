class AddNamesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :nick_name, :string
    add_column :users, :gender, :string
  end
end
