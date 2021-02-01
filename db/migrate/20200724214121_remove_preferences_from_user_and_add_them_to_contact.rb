class RemovePreferencesFromUserAndAddThemToContact < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :preference
    add_column :contactos, :preference, :string
  end
end
