class AddPreferenceToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :preference1, :string
    add_column :users, :preference2, :string
  end
end
