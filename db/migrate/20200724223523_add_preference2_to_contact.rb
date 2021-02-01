class AddPreference2ToContact < ActiveRecord::Migration[6.0]
  def change
    add_column :contactos, :preference2, :string
  end
end
