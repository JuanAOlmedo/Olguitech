class ChangeProyectosTableName < ActiveRecord::Migration[7.0]
  def change
    rename_table :proyectos, :projects
  end
end
