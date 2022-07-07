class AddStatusToProyectos < ActiveRecord::Migration[7.0]
  def change
    add_column :proyectos, :status, :integer
  end
end
