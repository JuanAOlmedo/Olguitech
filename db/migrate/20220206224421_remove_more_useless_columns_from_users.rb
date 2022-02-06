class RemoveMoreUselessColumnsFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :preference1, :string
    remove_column :users, :preference2, :string
  end
end
