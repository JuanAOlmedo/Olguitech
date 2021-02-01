class AddPreferencesToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :preference, :string
  end
end
