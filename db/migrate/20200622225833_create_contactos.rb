class CreateContactos < ActiveRecord::Migration[6.0]
  def change
    create_table :contactos do |t|

      t.timestamps
    end
  end
end
