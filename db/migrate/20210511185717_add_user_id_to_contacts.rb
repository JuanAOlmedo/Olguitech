class AddUserIdToContacts < ActiveRecord::Migration[6.1]
  def change
    add_column :contactos, :user_id, :integer
  end
end
