class AddSlugToProyectos < ActiveRecord::Migration[7.0]
  def change
    add_column :proyectos, :slug, :string
    add_index :proyectos, :slug, unique: true
  end
end
