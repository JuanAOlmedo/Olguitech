class AddTitleAndDescriptionToProyects < ActiveRecord::Migration[6.0]
  def change
    # remove_column :proyectos, :title
    add_column :proyectos, :description, :text
  end
end
