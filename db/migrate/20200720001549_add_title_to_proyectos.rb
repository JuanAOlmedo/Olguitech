class AddTitleToProyectos < ActiveRecord::Migration[6.0]
  def change
    add_column :proyectos, :title, :text
  end
end
