class RemoveNameFromAdmins < ActiveRecord::Migration[6.0]
  def change
    remove_column :admins, :name, :string
  end
end
