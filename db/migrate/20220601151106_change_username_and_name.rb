class ChangeUsernameAndName < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :name, :string, null:false
    change_column :users, :username, :string, null:false
  end
end
