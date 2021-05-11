class AddMessageToContacts < ActiveRecord::Migration[6.1]
  def change
    add_column :contactos, :message, :text
  end
end
